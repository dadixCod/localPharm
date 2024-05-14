// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:localpharm/core/extensions/extensions.dart';

class ImageContainerPicker extends StatefulWidget {
  final Function storeImage;
  final String? imagePath;
  const ImageContainerPicker({
    super.key,
    required this.storeImage,
    this.imagePath,
  });

  @override
  State<ImageContainerPicker> createState() => _ImageContainerPickerState();
}

class _ImageContainerPickerState extends State<ImageContainerPicker> {
  File? _pickedImage;

  @override
  void initState() {
    if (widget.imagePath != null) {
      _pickedImage = File(widget.imagePath!);
    }
    super.initState();
  }

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.camera);
    if (imageFile == null) {
      return;
    }
    setState(() {
      _pickedImage = File(imageFile.path);
    });
    widget.storeImage(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    final size = context.deviceSize;
    return GestureDetector(
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
        child: _pickedImage == null
            ? Icon(
                Icons.camera_alt_outlined,
                color: context.colorScheme.background.withOpacity(0.6),
                size: 50,
              )
            : Image.file(
                _pickedImage!,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
