import 'home_model.dart';

abstract class HomeState {}

class Init extends HomeState {}

class FilteredState extends HomeState {
  final List<PetDetailsModel> filteredList;

  FilteredState({required this.filteredList});
}
