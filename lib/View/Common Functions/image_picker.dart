// ignore_for_file: avoid_print, unused_local_variable

import 'dart:io';
import 'dart:convert';
import 'package:occasional_pockets/linked_screens.dart';

selectImage() async {
  final ImagePicker picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  File image;
  if (pickedFile != null) {
    image = File(pickedFile.path);
    return base64Encode(image.readAsBytesSync());
  } else {
    print('No image selected.');
    return;
  }
}
