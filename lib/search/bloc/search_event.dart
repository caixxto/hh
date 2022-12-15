abstract class SearchEvent {}

class SearchButtonPressed extends SearchEvent {
  final String request;

  SearchButtonPressed(this.request);
}

class SaveButtonPressed extends SearchEvent {

}