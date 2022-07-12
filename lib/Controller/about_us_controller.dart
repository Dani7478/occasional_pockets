// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:get/get.dart';
import 'package:occasional_pockets/linked_screens.dart';

class AboutUsController extends GetxController {
  bool isDark = false;
  String? image;
  String? email = 'Pending';
  String? userName = 'Pending';

  updateDarkMood(bool val) {
    isDark = val;
    update();
    print(val);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    callingfunctions();
  }

  callingfunctions() async {
    await getEmail();
    await getImage();
    await getUserName();
  }

  getEmail() async {
    final ref = await SharedPreferences.getInstance();
    email = ref.getString('email')!;
    print(email);
  }

  getImage() {
    FirebaseFirestore.instance
        .collection('marquee')
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) async {
                print('Fetching record...');
                image = doc['image'];
                update();
                print(image);
              }),
            });
  }

  getUserName() {
    FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) async {
                userName = doc['name'];
                update();
              }),
            });
  }
}
