import 'package:flutter/material.dart';
import 'package:localpharm/core/extensions/extensions.dart';

class ButtonShape extends StatelessWidget {
  final String buttonText;
  const ButtonShape({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    final size = context.deviceSize;
    return Container(
      height: 64,
      width: size.width,
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          buttonText,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: context.colorScheme.background,
          ),
        ),
      ),
    );
  }
}
