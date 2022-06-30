// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:occasional_pockets/linked_screens.dart';

class AdminMakeownController extends GetxController {
  int outdoorservice = 0;
  int price = 000;
  int photoPrice = 00;

  int numberOfPeople = 000;
  String? email;
  List foodNameList = [];
  List djList = [];
  List decorationList = [];
  List<bool> isExpanded = [false, false, false, false, false];
  int totalPhotos = 15;
  List foodImageList = [];
  List decorationImageList = [];
  List djImageList = [];
  List foodPriceList = [];
  List decorationPriceList = [];
  List djPriceList = [];

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
          .where('package', isEqualTo: 'makeown')
          .get()
          .then((QuerySnapshot querySnapshot) => {
                querySnapshot.docs.forEach((doc) async {
                  print('Printing....');
                  //  price = int.parse(doc['price'].toString());
                  // numberOfPeople = int.parse(doc['people'].toString());
                  // totalPhotos = int.parse(doc['photo'].toString());
                  foodNameList = doc['foodList'];
                  decorationList = doc['decorationList'];
                  djList = doc['djList'];
                  foodImageList = await doc['foodimages'];
                  foodPriceList = doc['foodPriceList'];
                  decorationImageList = await doc['decorationImages'];
                  decorationPriceList = doc['decorationPriceList'];
                  djImageList = await doc['djImage'];
                  djPriceList = doc['djPriceList'];
                  photoPrice = doc['photoprice'];
                  outdoorservice = doc['outdoorprice'];
                  update();
                }),
              });
    } catch (e) {
      print('Error $e');
    }
  }
}
