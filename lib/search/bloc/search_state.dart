import 'package:hh_parse/vacancy_rep.dart';

abstract class SearchState {}

class InitialState extends SearchState {}

class UpdateScreen extends SearchState {
  final List<Vacancy> vacancies;
  UpdateScreen(this.vacancies);
}

class ErrorState extends SearchState {}