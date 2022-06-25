import 'package:occasional_pockets/linked_screens.dart';

class AdminBasicController extends GetxController {
  String? price;
  String? numberOfPeople;
  List<String> foodNameList = [
    'Bariyani',
    'Channay',
    'Khaddi Kebab ',
    'Sohan Halwa',
    'Kheer '
  ];
  List<String> djList = [
    'DJ Asif Butt',
    'DJ Ali Safina',
    'DJ Yasmin Yousaf ',
  ];
  List<bool> isExpanded = [false, false, false, false, false];

  updateExpanded(int index) {
    if (isExpanded[index]) {
      isExpanded[index] = false;
    } else {
      isExpanded[index] = true;
    }
    update();
  }
}
