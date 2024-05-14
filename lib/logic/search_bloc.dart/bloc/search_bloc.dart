import 'package:bloc/bloc.dart';
import 'package:localpharm/backend/database_provider.dart';
import 'package:localpharm/backend/models/medicament.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final DbProvider dbProvider;
  SearchBloc(this.dbProvider) : super(SearchInitial(medicaments: [])) {
    on<SearchMedicament>((event, emit) async {
        
        if (event.searchedText == null || event.searchedText!.isEmpty) {
          emit(SearchInitial(medicaments: []));
        } else {
          final List<Medicament> allMeds = await dbProvider.getAllTasks();
          final List<Medicament> searchedMeds = allMeds
              .where(
                  (med) => med.name.toLowerCase().contains(event.searchedText!))
              .toList();
          emit(SearchInitial(medicaments: searchedMeds));
        }
      });
  }
}
