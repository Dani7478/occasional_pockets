// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:occasional_pockets/linked_screens.dart';

class AdminFeedbackController extends GetxController {
  List allFeedbackList = [];
  List userFeedbackList = [];
  List adminFeedbackList = [];
  String? userEmail;
  bool loading = true;

  @override
  void onInit() {
    super.onInit();
    getEmail();
  }

  getEmail() async {
    final pref = await SharedPreferences.getInstance();
    userEmail = pref.getString('email');
    await getAdminFeedBack();
    await getUserFeedBack();
  }

  getAdminFeedBack() {
    print(userEmail);
    adminFeedbackList.clear();
    var db = FirebaseFirestore.instance.collection('feedback');
    db
        .where('recieverEmail', isEqualTo: userEmail)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) async {
                adminFeedbackList.add(doc);
                update();
              }),
            });
  }

  getUserFeedBack() {
    print(userEmail);
    userFeedbackList.clear();
    var db = FirebaseFirestore.instance.collection('feedback');
    db
        .where('senderEmail', isEqualTo: userEmail)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) async {
                userFeedbackList.add(doc);
                update();
              }),
            });
    loading = false;
    update();
  }
}
