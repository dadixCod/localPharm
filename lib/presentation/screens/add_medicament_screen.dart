import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localpharm/backend/models/medicament.dart';
import 'package:localpharm/core/extensions/extensions.dart';
import 'package:localpharm/logic/blocs/medicament_bloc.dart';
import 'package:localpharm/presentation/widgets/button_shape.dart';
import 'package:localpharm/presentation/widgets/image_container_picker.dart';
import 'package:localpharm/presentation/widgets/name_text_field.dart';
import 'package:localpharm/presentation/widgets/row_date_picker.dart';

class AddMedicamentScreen extends StatefulWidget {
  const AddMedicamentScreen({super.key});

  @override
  State<AddMedicamentScreen> createState() => _AddMedicamentScreenState();
}

GlobalKey<FormState> key = GlobalKey<FormState>();
late TextEditingController nameController;

class _AddMedicamentScreenState extends State<AddMedicamentScreen> {
  @override
  void initState() {
    nameController = TextEditingController();
    super.initState();
  }

  File? _pickedImage;
  void _selectImage(File? pickedImage) {
    _pickedImage = pickedImage;
  }

  DateTime? expiryDate = DateTime.now();
  void _selectDate(DateTime date) {
    expiryDate = date;
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = context.deviceSize;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: context.colorScheme.primary,
        foregroundColor: context.colorScheme.background,
        title: const Text(
          "Ajouter un médicament",
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Container(
        height: size.height * 0.9,
        width: size.width,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Form(
          key: key,
          child: Column(
            children: [
              ImageContainerPicker(storeImage: _selectImage),
              NameTextField(controller: nameController),
              const SizedBox(height: 15),
              RowDatePicker(dateSelected: _selectDate),
              SizedBox(
                height: size.height * 0.25,
              ),
              GestureDetector(
                onTap: () {
                  if (key.currentState!.validate()) {
                    final newMedicament = Medicament(
                      name: nameController.text,
                      imagePath: _pickedImage?.path,
                      date: expiryDate.toString(),
                      isExpired: false,
                    );
                    context
                        .read<MedicamentBloc>()
                        .add(AddMedicament(medicament: newMedicament));

                    Navigator.of(context).pop();
                  }
                },
                child: const ButtonShape(
                  buttonText: 'Ajouter',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
