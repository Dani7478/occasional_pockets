// ignore_for_file: avoid_print
// ignore: unused_local_variable
import 'package:flutter/material.dart';
import 'package:occasional_pockets/Model/user_model.dart';
import 'package:occasional_pockets/View/Common%20Widgets/snack_bar.dart';
import 'package:occasional_pockets/View/Screens/Authentication/login_view.dart';
import 'package:occasional_pockets/linked_screens.dart';

class RegistrationController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController passwController = TextEditingController();
  String role = 'user';

//________________UPDATE ROLE
  updateRole(String value) {
    role = value;
    update();
  }

//______________________________POST USER DATA
  postData() async {
    final prefs = await SharedPreferences.getInstance();
    String msg = '';
    if (nameController.text == '') {
      msg = 'Please enter name';
    } else if (emailController.text == '') {
      msg = 'Please enter name';
      if (!emailController.text.contains('@')) {
        msg = 'Please Enter Valid Email';
      }
    } else if (contactController.text.length < 11) {
      msg = 'Please Enter Valid Phone no';
    } else if (cityController.text == '') {
      msg = 'Please Enter City Name';
    } else if (passwController.text.length < 8) {
      msg = 'Enter Strong Password';
    } else {
      var data = {
        'name': nameController.text,
        'email': emailController.text,
        'phone': contactController.text,
        'city': cityController.text,
        'role': role,
        'password': passwController.text
      };
      var result =
          await FirebaseFirestore.instance.collection("user").add(data);
      if (result.id != null) {
        await prefs.setString('email', emailController.text);
        await prefs.setString('phone', contactController.text);
        await prefs.setString('role', role);
        snackBar('Register Successfully', 'Please login now', Icons.done_all);
        navigatorScreen(const MarqueeFormView());
      }
    }
    snackBar('ALERT...!', msg, Icons.error);
  }
}
