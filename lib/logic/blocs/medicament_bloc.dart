import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localpharm/backend/database_provider.dart';
import 'package:localpharm/backend/models/medicament.dart';

part './medicament_state.dart';
part './medicament_event.dart';

class MedicamentBloc extends Bloc<MedicamentEvent, MedicamentState> {
  final DbProvider dbProvider;
  MedicamentBloc(this.dbProvider) : super(MedicamentsLoaded([])) {
    on<GetAllMedicaments>(
      (event, emit) async {
        List<Medicament> medicaments = await dbProvider.getAllTasks();
        emit(MedicamentsLoaded(medicaments));
      },
    );
    on<AddMedicament>(
      (event, emit) async {
        await dbProvider.addMedicament(event.medicament);
        add(GetAllMedicaments());
      },
    );

    on<UpdateMedicament>(
      (event, emit) async {
        await dbProvider.updateMedicament(event.medicament);
        add(GetAllMedicaments());
      },
    );
    on<DeleteMedicament>(
      (event, emit) async {
        await dbProvider.deleteMedicament(event.medicament);
        add(GetAllMedicaments());
      },
    );

    
  }
}
