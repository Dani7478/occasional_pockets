// ignore_for_file: avoid_print

import 'package:occasional_pockets/linked_screens.dart';

class AdminHomeController extends GetxController {
  int index = 1;
  String marqueeName = 'Pending...';
  String marqueeAddress = 'Pending';
  String email = '';

  updateindex(int value) {
    index = value;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    callingFunction();
  }

  callingFunction() async {
    await getEmail();
    await getName();
  }

  getEmail() async {
    print('Geting email...');
    final ref = await SharedPreferences.getInstance();
    email = ref.getString('email')!;
    print(email);
  }

  getName() {
    print('Geting Name....');
    FirebaseFirestore.instance
        .collection('marquee')
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) async {
                print('Fetching record...');
                marqueeName = doc['marqueeName'];
                marqueeAddress = doc['marqueeAddress'];
                update();
              }),
            });
    print(marqueeName);
  }
}
