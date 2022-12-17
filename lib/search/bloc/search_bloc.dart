import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hh_parse/network.dart';
import 'package:hh_parse/search/bloc/search_event.dart';
import 'package:hh_parse/search/bloc/search_state.dart';
import 'package:hh_parse/vacancy_rep.dart';
import 'package:html/parser.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';


class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final VacancyRepository _repository = VacancyRepository.instance;
  final List<String> _vac = [];
  late int pagess = 0;

  SearchBloc() : super(InitialState()) {
    _initState();

    on<SearchButtonPressed>((event, state) async {
      _sendRequest(event.request);
    });

    on<SaveButtonPressed>((event, state) async {
      _saveData();
    });

  }

  Future<void> _saveData() async {
    final vac = _repository.getVacancies;
    final rows = vac.length;

    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];

    for (var i = 0; i < rows; i++) {
      sheet.getRangeByName('A1').setText('№');
      sheet.getRangeByName('B1').setText('Название');
      sheet.getRangeByName('C1').setText('Просматривают');
      sheet.getRangeByName('D1').setText('Ссылка');
      sheet.getRangeByName('A${i+2}').setNumber(i+1);
      sheet.getRangeByName('B${i+2}').setText(vac[i].name);
      sheet.getRangeByName('C${i+2}').setNumber(vac[i].users);
      sheet.getRangeByName('D${i+2}').setText(vac[i].href);
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = '$path\\Output.xlsx';
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(fileName);

  }


  Future<void> _initState() async {
    _updateScreen();
  }

  Future<void> _sendRequest(String request) async {
    final session = Network.instance;
    final data = await session.search(request, 0);
    await _parseData(data);

    for (var i = 1; i <= pagess; i++) {
      final data = await session.searchFromPages(request, i);
      await _parseData(data);
    }
  }
  
  Future<void> _parseData(data) async {
    final document = parse(data);
    final vacancy = document.querySelectorAll(".serp-item > div > div.vacancy-serp-item-body");
    //print(vacancy.length);


    if (pagess == 0) {
      final pages = document.querySelector(".pager");
      pages!.children.removeLast();
      var a = pages!.children.last.querySelector('.bloko-button');
      pagess = int.parse(a!.text);
      //print(pagess);
    }

    for (var i = 0; i < vacancy.length; i++) {
        final name = vacancy[i].querySelector("div > div > h3");
        final users = vacancy[i].querySelector("div.vacancy-serp-item-body__main-info > div.online-users--tWT3_ck7eF8Iv5SpZ6WL");
        final htmlHref = vacancy[i].querySelector("div.vacancy-serp-item-body__main-info");
        final href = htmlHref!.getElementsByTagName('a')
            .where((e) => e.attributes.containsKey('href'))
        .map((e) => e.attributes['href'])
        .toList();

        RegExp exp = RegExp("[0-9]]");
        var views = double.parse(users?.text.replaceAll(RegExp('[^0-9]'), '') ?? '0');

        _repository.addNewVacancy(Vacancy(id: i, name: name?.text ?? 'error name', users: views, href: href[0] ?? 'no link'));
    }
    _updateScreen();
  }

  void _updateScreen() {
    emit(UpdateScreen(_repository.getVacancies));
  }


}