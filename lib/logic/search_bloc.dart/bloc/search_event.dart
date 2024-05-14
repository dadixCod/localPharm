part of 'search_bloc.dart';

abstract class SearchEvent {}

class SearchMedicament extends SearchEvent {
  final String? searchedText;

  SearchMedicament(this.searchedText);

}

