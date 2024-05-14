import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:localpharm/backend/models/medicament.dart';
import 'package:localpharm/core/extensions/extensions.dart';
import 'package:localpharm/logic/blocs/medicament_bloc.dart';

class UpdateMedicamentScreen extends StatefulWidget {
  final Medicament medicament;
  const UpdateMedicamentScreen({super.key, required this.medicament});

  @override
  State<UpdateMedicamentScreen> createState() => _UpdateMedicamentScreenState();
}

GlobalKey<FormState> key = GlobalKey<FormState>();
late TextEditingController nameController;

class _UpdateMedicamentScreenState extends State<UpdateMedicamentScreen> {
  @override
  void initState() {
    nameController = TextEditingController();
    super.initState();
  }

  File? _pickedImage;

  DateTime expiryDate = DateTime.now();
  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.camera);
    if (imageFile == null) {
      return;
    }
    setState(() {
      _pickedImage = File(imageFile.path);
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = context.deviceSize;

    expiryDate = DateTime.parse(widget.medicament.date);
    if (widget.medicament.imagePath != null) {
      _pickedImage = File(widget.medicament.imagePath!);
    }
    String formattedExpiryDate = DateFormat.yM().format(expiryDate);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: context.colorScheme.primary,
        foregroundColor: context.colorScheme.background,
        title: const Text(
          "Editer un médicament",
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
              GestureDetector(
                onTap: () {
                  _takePicture();
                },
                child: Container(
                  width: size.width * 0.4,
                  height: size.height * 0.2,
                  margin: const EdgeInsets.only(top: 40, bottom: 20),
                  decoration: BoxDecoration(
                    color: context.colorScheme.tertiary,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: context.colorScheme.primary,
                      strokeAlign: BorderSide.strokeAlignInside,
                      width: 2,
                    ),
                  ),
                  child: widget.medicament.imagePath == null
                      ? Image.asset(
                          'assets/images/empty_meds.png',
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          _pickedImage!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              TextFormField(
                controller: nameController,
                onTapOutside: (_) =>
                    FocusScope.of(context).requestFocus(FocusNode()),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Le nom du médicament ne peut pas être vide';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Nom',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                width: size.width,
                height: 64,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: context.colorScheme.outline,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        formattedExpiryDate,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year + 10),
                        );
                        if (date == null) {
                          return;
                        }
                        setState(() {
                          expiryDate = date;
                        });
                      },
                      icon: const Icon(
                        Icons.calendar_month_outlined,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.25,
              ),
              GestureDetector(
                onTap: () {
                  if (key.currentState!.validate()) {
                    final updatedMedicament = Medicament(
                      id: widget.medicament.id,
                      name: nameController.text,
                      imagePath: _pickedImage?.path,
                      date: expiryDate.toString(),
                      isExpired: false,
                    );
                    context
                        .read<MedicamentBloc>()
                        .add(UpdateMedicament(medicament: updatedMedicament));

                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  height: 64,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Editer",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: context.colorScheme.background,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
