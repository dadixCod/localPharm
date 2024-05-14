part of './medicament_bloc.dart';

abstract class MedicamentState {}

class MedicamentsLoaded extends MedicamentState {
  final List<Medicament> medicaments;
  MedicamentsLoaded(this.medicaments);
}

class MedicamentsSearched extends MedicamentState {
  final List<Medicament> medicaments;
  MedicamentsSearched(this.medicaments);
}

class MedicamentAdded extends MedicamentState {}

class MedicamentUpdated extends MedicamentState {}

class MedicamentDeleted extends MedicamentState {}
