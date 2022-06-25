import 'package:occasional_pockets/linked_screens.dart';

navigatorScreen(var screenName) {
  Get.to(
    screenName,
    duration: const Duration(milliseconds: 500),
    transition: Transition.rightToLeft,
  );
}
