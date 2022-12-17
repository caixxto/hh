import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row;


class Vacancy {
  int? id;
  final String name;
  final double users;
  final String href;

  Vacancy({this.id, required this.name, required this.users, required this.href});
}

class VacancyRepository {
  static final VacancyRepository  _instance = VacancyRepository._();

  VacancyRepository._();

  static VacancyRepository get instance => _instance;

  final List<Vacancy> _list = List.empty(growable: true);

  List<Vacancy> get getVacancies => _list;

  void addNewVacancy(Vacancy vacancy) => _list.add(vacancy);

}