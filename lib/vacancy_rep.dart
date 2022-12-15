import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row;


class Vacancy {
  int? id;
  final String name;
  final String users;

  Vacancy({this.id, required this.name, required this.users});
}

class VacancyRepository {
  static final VacancyRepository  _instance = VacancyRepository._();

  VacancyRepository._();

  static VacancyRepository get instance => _instance;

  final List<Vacancy> _list = List.empty(growable: true);

  List<Vacancy> get getVacancies => _list;

  void addNewVacancy(Vacancy vacancy) => _list.add(vacancy);

}


// class VacancyDataSource extends DataGridSource {
//
//   VacancyDataSource({required List<Vacancy> vacancyData}) {
//     _vacancyData = vacancyData.map<DataGridRow>((Vacancy e) => DataGridRow(cells: <DataGridCell>[
//       DataGridCell<int>(columnName: 'ID', value: e.id),
//       DataGridCell<String>(columnName: 'VACANCY', value: e.name),
//       DataGridCell<String>(columnName: 'VIEWERS', value: e.users),
//     ]))
//         .toList();
//   }
//
//   List<DataGridRow> _vacancyData = <DataGridRow>[];
//
//   @override
//   List<DataGridRow> get rows => _vacancyData;
//
//   @override
//   DataGridRowAdapter buildRow(DataGridRow row) {
//     return DataGridRowAdapter(
//         cells: row.getCells().map<Widget>((DataGridCell cell) {
//           return Container(
//             alignment: Alignment.center,
//             padding: const EdgeInsets.all(8.0),
//             child: Text(cell.value.toString()),
//           );
//         }).toList()
//     );
//   }
// }