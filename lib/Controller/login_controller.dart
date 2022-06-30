// ignore_for_file: avoid_print, unused_local_variable

import 'package:occasional_pockets/View/Common%20Widgets/snack_bar.dart';
import 'package:occasional_pockets/View/Screens/Admin%20view/admin_startup_view.dart';
import 'package:occasional_pockets/linked_screens.dart';

class LoginController extends GetxController {
  var emailController = TextEditingController();
  var passwController = TextEditingController();

  updateController() {
    print('email : ${emailController.text}');
    print('password : ${passwController.text}');
  }

  checkUser() async {
    print('Caling..............');
    final prefs = await SharedPreferences.getInstance();
    String email = emailController.text;
    String password = passwController.text;
    int check = 0;
    try {
      var response = await FirebaseFirestore.instance
          .collection('user')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get()
          .then((QuerySnapshot querySnapshot) => {
                // ignore: avoid_function_literals_in_foreach_calls
                querySnapshot.docs.forEach((doc) async {
                  check = 1;
                  await prefs.setString('email', doc['email']);
                  await prefs.setString('phone', doc['phone']);
                  await prefs.setString('role', doc['role']);
                  String role = doc['role'];
                  if (role.toLowerCase() == 'user') {
                    print('User.............');
                  }
                  if (role.toLowerCase() == 'admin') {
                    navigatorScreen(const AdminStartUpView());
                    snackBar('Congratulations', 'Welcome in Occasional Pockets',
                        Icons.done_all);
                  }
                }),
              });
    } catch (e) {
      print('Error $e');
    }
    if (check == 0) {
      snackBar('Alert', 'Wrong Email or Password', Icons.error);
    }
  }
}
