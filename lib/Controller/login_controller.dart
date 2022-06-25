import 'package:occasional_pockets/linked_screens.dart';

class LoginController extends GetxController {
  var emailController = TextEditingController();
  var passwController = TextEditingController();

  updateController() {
    print('email : ${emailController.text}');
    print('password : ${passwController.text}');
  }
}
