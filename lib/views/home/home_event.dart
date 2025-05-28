abstract class HomeEvent {}

class SearchPetsEvent extends HomeEvent {
  final String query;

  SearchPetsEvent(this.query);
}
