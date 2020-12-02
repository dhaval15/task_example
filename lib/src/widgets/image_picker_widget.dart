import 'dart:io';

import 'package:flutter/material.dart';
import 'package:extras/extras.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({Key key}) : super(key: key);
  @override
  ImagePickerWidgetState createState() => ImagePickerWidgetState();
}

class ImagePickerWidgetState extends State<ImagePickerWidget> {
  File image;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 304,
      child: GestureDetector(
        child: image != null
            ? Image.file(
                image,
                fit: BoxFit.cover,
              )
            : Icon(
                Icons.add_a_photo,
                size: 48,
                color: context.disabled,
              ).center(),
        onTap: _pickImage,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: context.disabled,
          width: 2,
        ),
      ),
    );
  }

  void _pickImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }
}
