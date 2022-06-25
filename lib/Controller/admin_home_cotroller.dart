import 'package:occasional_pockets/linked_screens.dart';

class AdminHomeController extends GetxController {
  int index = 1;
  String companyName = 'Marquee Name';

  updateindex(int value) {
    index = value;
    update();
  }
}
