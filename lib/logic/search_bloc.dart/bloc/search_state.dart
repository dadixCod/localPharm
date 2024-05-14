// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

abstract class SearchState {
  const SearchState();
}

class SearchInitial extends SearchState {
  List<Medicament> medicaments;
  SearchInitial({
    required this.medicaments,
  });
  
}
