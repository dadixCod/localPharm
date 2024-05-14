import 'package:flutter/material.dart';

class NameTextField extends StatelessWidget {
  final TextEditingController controller;
  const NameTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTapOutside: (_) => FocusScope.of(context).requestFocus(FocusNode()),
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
    );
  }
}
