part of './medicament_bloc.dart';

abstract class MedicamentEvent {}

class GetAllMedicaments extends MedicamentEvent {}

class AddMedicament extends MedicamentEvent {
  final Medicament medicament;

  AddMedicament({required this.medicament});
}

class UpdateMedicament extends MedicamentEvent {
  final Medicament medicament;

  UpdateMedicament({required this.medicament});
}

class DeleteMedicament extends MedicamentEvent {
  final Medicament medicament;

  DeleteMedicament({required this.medicament});
}

