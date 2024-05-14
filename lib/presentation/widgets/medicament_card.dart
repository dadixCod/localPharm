// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:localpharm/backend/models/medicament.dart';
import 'package:localpharm/core/extensions/extensions.dart';
import 'package:localpharm/core/utils/helpers.dart';
import 'package:localpharm/logic/blocs/medicament_bloc.dart';
import 'package:localpharm/presentation/widgets/button_shape.dart';
import 'package:localpharm/presentation/widgets/image_container_picker.dart';
import 'package:localpharm/presentation/widgets/name_text_field.dart';
import 'package:localpharm/presentation/widgets/row_date_picker.dart';

class MedicamentCard extends StatelessWidget {
  final Medicament medicament;
 
  const MedicamentCard({super.key, required this.medicament});

  @override
  Widget build(BuildContext context) {
    final Helpers helpers = Helpers();
    final size = context.deviceSize;
    TextEditingController nameController = TextEditingController();
    DateTime? expiryDate = DateTime.now();
    void _selectDate(DateTime date) {
      expiryDate = date;
    }

    File? _pickedImage;
    void _selectImage(File? pickedImage) {
      _pickedImage = pickedImage;
    }

    final actualDate = helpers.stringToDate(medicament.date);
    bool isExpired =
        actualDate == DateTime.now() || actualDate.isBefore(DateTime.now());

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/details', arguments: medicament);
      },
      child: Slidable(
        endActionPane: ActionPane(motion: const ScrollMotion(), children: [
          SlidableAction(
            onPressed: (context) {
              context
                  .read<MedicamentBloc>()
                  .add(DeleteMedicament(medicament: medicament));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Médicament supprimé avec succès',
                    style: TextStyle(
                      color: context.colorScheme.background,
                    ),
                  ),
                  backgroundColor: context.colorScheme.error,
                ),
              );
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
            borderRadius: BorderRadius.circular(8),
          ),
        ]),
        child: Container(
          width: size.width,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: isExpired
                ? context.colorScheme.error
                : context.colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 70,
                width: 70,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: medicament.imagePath == null
                    ? Image.asset(
                        'assets/images/empty_meds.png',
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        File(medicament.imagePath!),
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      medicament.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isExpired
                            ? context.colorScheme.background
                            : context.colorScheme.inverseSurface,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      DateFormat.yM().format(actualDate),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: isExpired
                            ? context.colorScheme.background
                            : context.colorScheme.inverseSurface,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  nameController.text = medicament.name;
                  expiryDate = helpers.stringToDate(medicament.date);
                  showGeneralDialog(
                      barrierDismissible: true,
                      barrierLabel: 'update',
                      context: context,
                      transitionBuilder:
                          (context, animation, secondaryAnimation, child) {
                        Tween<Offset> tween;
                        tween = Tween<Offset>(
                            begin: const Offset(0, -1), end: Offset.zero);
                        return SlideTransition(
                          position: tween.animate(
                            CurvedAnimation(
                              parent: animation,
                              curve: Curves.fastOutSlowIn,
                            ),
                          ),
                          child: child,
                        );
                      },
                      pageBuilder: (context, _, __) {
                        return Center(
                          child: Container(
                            width: size.width * 0.9,
                            height: size.height * 0.8,
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: context.colorScheme.background,
                            ),
                            child: Scaffold(
                              resizeToAvoidBottomInset: false,
                              backgroundColor: Colors.transparent,
                              body: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Editer un medicament",
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  ImageContainerPicker(
                                    storeImage: _selectImage,
                                    imagePath: medicament.imagePath,
                                  ),
                                  NameTextField(controller: nameController),
                                  const SizedBox(height: 20),
                                  RowDatePicker(
                                    dateSelected: _selectDate,
                                    expiryDate: expiryDate,
                                  ),
                                  const SizedBox(height: 20),
                                  GestureDetector(
                                    onTap: () {
                                      final updatedMedicament = Medicament(
                                        id: medicament.id,
                                        name: nameController.text,
                                        imagePath: _pickedImage == null
                                            ? medicament.imagePath
                                            : _pickedImage?.path,
                                        date: expiryDate.toString(),
                                        isExpired: isExpired,
                                      );
                                      context.read<MedicamentBloc>().add(
                                            UpdateMedicament(
                                                medicament: updatedMedicament),
                                          );
                                      Navigator.of(context).pop();
                                    },
                                    child:
                                        const ButtonShape(buttonText: 'Editer'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
                icon: Icon(
                  Icons.edit,
                  color: isExpired
                      ? context.colorScheme.background
                      : context.colorScheme.primary,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
