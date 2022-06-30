// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:occasional_pockets/linked_screens.dart';

class AdminPlatinumController extends GetxController {
  int price = 000;
  int numberOfPeople = 000;
  String? email;
  List foodNameList = [];
  List djList = [];
  List decorationList = [];
  List<bool> isExpanded = [false, false, false, false, false];
  int totalPhotos = 00;
  List foodImageList = [];
  List decorationImageList = [];
  List djImageList = [];

  updateExpanded(int index) {
    if (isExpanded[index]) {
      isExpanded[index] = false;
    } else {
      isExpanded[index] = true;
    }
    update();
  }

  @override
  void onInit() {
    callingFunction();
    super.onInit();
  }

  callingFunction() async {
    await getEmail();
  }

  getEmail() async {
    final ref = await SharedPreferences.getInstance();
    email = ref.getString('email')!;
    await getBasicPackageDetail();
  }

  getBasicPackageDetail() async {
    var db = FirebaseFirestore.instance.collection('package');
    print(email);
    try {
      var response = await db
          .where('email', isEqualTo: email)
          .where('package', isEqualTo: 'platinum')
          .get()
          .then((QuerySnapshot querySnapshot) => {
                querySnapshot.docs.forEach((doc) async {
                  print('Printing....');
                  price = int.parse(doc['price'].toString());
                  numberOfPeople = int.parse(doc['people'].toString());
                  totalPhotos = int.parse(doc['photo'].toString());
                  foodNameList = doc['foodList'];
                  decorationList = doc['decorationList'];
                  djList = doc['djList'];
                  foodImageList = await doc['foodimages'];
                  decorationImageList = await doc['decorationImages'];
                  djImageList = await doc['djImage'];
                  update();
                }),
              });
    } catch (e) {
      print('Error $e');
    }
  }
}
