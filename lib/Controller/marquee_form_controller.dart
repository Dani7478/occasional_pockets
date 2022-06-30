import 'dart:convert';
import 'dart:io';

import 'package:occasional_pockets/View/Common%20Widgets/snack_bar.dart';
import 'package:occasional_pockets/View/Screens/Admin%20view/admin_startup_view.dart';
import 'package:occasional_pockets/linked_screens.dart';

class MarqueeFromController extends GetxController {
  String? image;
  String? email;
  File? imgageFile;
  var marqueeName = TextEditingController();
  var marqueeAddress = TextEditingController();
  var marqueeCity = TextEditingController();

  updateImage(String imageurl) {
    image = imageurl;
    update();
  }

  postData() async {
    String msg = '';
    if (image == null) {
      msg = 'Please Select Image';
    } else if (marqueeName.text == '') {
      msg = 'Please Enter Marquee Name';
    } else if (marqueeAddress.text == '') {
      msg = 'Please Enter Marquee Address';
    } else if (marqueeCity.text == '') {
      msg = 'Please Enter Marquee City';
    } else {
      var data = {
        'image': image,
        'marqueeName': marqueeName.text,
        'marqueeCity': marqueeCity.text,
        'marqueeAddress': marqueeAddress.text,
        'email': email,
      };
      var result =
          await FirebaseFirestore.instance.collection("marquee").add(data);
      // ignore: unnecessary_null_comparison
      if (result != null) {
        snackBar('Alert...!', 'Marquee Detail Added Successfully', Icons.error);
        navigatorScreen(const AdminStartUpView());
      } else {
        msg = 'Something Went Wrong';
      }
    }
    snackBar('Alert...!', msg, Icons.error);
  }

  @override
  void onInit() {
    super.onInit();
    calling();
  }

  calling() async {
    final prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');
  }
}
