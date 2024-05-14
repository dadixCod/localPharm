import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:localpharm/backend/models/medicament.dart';
import 'package:localpharm/core/extensions/extensions.dart';
import 'package:localpharm/core/utils/helpers.dart';
import 'package:localpharm/logic/blocs/medicament_bloc.dart';

class MedicamentDetailScreen extends StatelessWidget {
  final Medicament medicament;
  const MedicamentDetailScreen({super.key, required this.medicament});

  @override
  Widget build(BuildContext context) {
    final actualDate = Helpers().stringToDate(medicament.date);
    bool isExpired =
        actualDate == DateTime.now() || actualDate.isBefore(DateTime.now());
    final size = context.deviceSize;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: isExpired
              ? context.colorScheme.error
              : context.colorScheme.primary,
          foregroundColor: context.colorScheme.background,
          title: const Text("Details"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
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
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.delete,
                size: 25,
              ),
            ),
          ],
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
            ),
          )),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                height: size.height * 0.3,
                width: size.width,
                decoration: BoxDecoration(
                  color: context.colorScheme.secondaryContainer,
                ),
                child: medicament.imagePath == null
                    ? Image.asset('assets/images/empty_meds.png')
                    : Image.file(
                        File(medicament.imagePath!),
                      ),
              ),
              Positioned.fill(
                child: ClipRRect(
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.8),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 20,
                child: SizedBox(
                  width: size.width * 0.7,
                  child: Text(
                    medicament.name,
                    style: TextStyle(
                      fontSize: 20,
                      color: context.colorScheme.background,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Date d'expiration : ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  DateFormat.yM().format(actualDate),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
