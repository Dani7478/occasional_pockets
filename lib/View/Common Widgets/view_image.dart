import 'dart:convert';
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  ImageView({Key? key, required this.image}) : super(key: key);

  String image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SizedBox(
        width: double.infinity,
        height: 250,
        child: Image.memory(
          base64.decode(image.toString()),
          fit: BoxFit.fill,
        ),
      ),
    ));
  }
}
