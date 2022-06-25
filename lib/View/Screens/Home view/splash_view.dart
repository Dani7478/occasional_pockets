import 'dart:async';
import 'package:flutter/material.dart';
import 'package:occasional_pockets/View/Screens/Authentication/login_view.dart';
import 'package:occasional_pockets/linked_screens.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () => navigatorScreen(const LoginView()));
    super.initState();
  }

  //_______________________________MAIN
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          UpperPortion(),
          LowerPortion(),
        ],
      ),
    );
  }
}

//____________________________________________UPPER IMAGE PORTION
class UpperPortion extends StatelessWidget {
  const UpperPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 6,
        child: Align(
          alignment: Alignment.center,
          child: Image.asset(
            'images/main_logo.png',
            height: 120,
            width: 200,
          ),
        ));
  }
}

//____________________________________________LOWER TEXT PORTION

class LowerPortion extends StatelessWidget {
  const LowerPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 4,
        child: Column(
          children: [
            Text('Occasional Pockets',
                style: GoogleFonts.josefinSans(
                    fontSize: 24,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 30),
            const SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                color: Colors.yellow,
              ),
            )
          ],
        ));
  }
}
