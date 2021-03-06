// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

import 'package:occasional_pockets/Model/user_model.dart';
import 'package:occasional_pockets/View/Common%20Widgets/snack_bar.dart';
import 'package:occasional_pockets/View/Screens/Admin%20view/Request/admin_request.dart';
import 'package:occasional_pockets/linked_screens.dart';

class AdminRequestController extends GetxController {
  String? email;
  bool ismakeown = false;
  List requestList = [];
  List singleList = [];

  @override
  void onInit() {
    super.onInit();
    getEmail();
    print('In it caliing');
  }

  //___________________GET EMAIL
  getEmail() async {
    final ref = await SharedPreferences.getInstance();
    email = ref.getString('email');
    getAllData();
  }

  //_______________getAllData
  getAllData() async {
    print('Fetching Request');
    var db = FirebaseFirestore.instance.collection('request');
    try {
      await db
          .where('recieverEmail', isEqualTo: email.toString().toLowerCase())
          .get()
          .then((QuerySnapshot querySnapshot) => {
                querySnapshot.docs.forEach((doc) async {
                  print('Fetching Request');
                  requestList.add(doc);
                  update();
                }),
              });
    } catch (e) {
      print('Error $e');
    }
    update();
  }

  //____________________fetch detail package
  fetchDetail(String id) async {
    ismakeown = false;
    singleList.clear();
    print('Geting New Record');
    var db = FirebaseFirestore.instance.collection('request');
    print(id);
    try {
      await db
          //where(db.doc().id.toString(), isEqualTo: id)
          .get()
          .then((QuerySnapshot querySnapshot) => {
                querySnapshot.docs.forEach((doc) async {
                  if (doc.id == id) {
                    print('fetching');
                    singleList.add(doc);
                    if (doc['package'] == 'makeown') {
                      ismakeown = true;
                    }
                    update();
                  }
                }),
              });
    } catch (e) {
      print('Error $e');
    }
    update();
  }

  //_________________update status
  updateStatus(String id, String newstaus) async {
    var db = FirebaseFirestore.instance.collection('request');
    try {
      db.doc(id).update({'status': newstaus});
      snackBar('Congratulation', 'Status Updated Successfully', Icons.done_all);
      requestList.clear();
      await getAllData();
      navigatorScreen(const AdminRequest());
      update();
    } catch (e) {
      snackBar('Oh No', 'Something Went Wrong', Icons.error);
    }
  }
}
