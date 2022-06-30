// ignore_for_file: camel_case_types

import 'dart:async';
import 'package:occasional_pockets/View/Screens/Admin%20view/admin_startup_view.dart';
import 'package:occasional_pockets/View/Screens/Authentication/login_view.dart';
import 'package:occasional_pockets/linked_screens.dart';

class Movement_Screen extends StatefulWidget {
  const Movement_Screen({Key? key}) : super(key: key);

  @override
  _Movement_ScreenState createState() => _Movement_ScreenState();
}

String? role;

class _Movement_ScreenState extends State<Movement_Screen> {
  whereMove() async {
    SharedPreferences prefrence = await SharedPreferences.getInstance();
    setState(() {
      role = prefrence.getString("role");
      print(role);
    });
    if (role == 'null') {
      navigatorScreen(const LoginView());
    } else {
      if (role == 'admin') {
        navigatorScreen(const AdminStartUpView());
      }
    }
  }

  void initState() {
    whereMove();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: loadingSpinner(),
    );
  }

  loadingSpinner() {
    return Center(
      child: SpinKitCircle(
        color: primaryColor,
        size: 80.0,
      ),
    );
  }
}
