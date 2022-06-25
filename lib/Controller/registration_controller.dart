import 'package:flutter/material.dart';
import 'package:occasional_pockets/linked_screens.dart';

class RegistrationController extends GetxController {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var contactController = TextEditingController();
  var cityController = TextEditingController();
  var passwController = TextEditingController();
  String role = 'user';

  updateRole(String value) {
    role = value;
    update();
  }
}
