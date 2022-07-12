// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:occasional_pockets/linked_screens.dart';

import '../../View/Common Widgets/snack_bar.dart';
import '../../View/Screens/User view/user_request_view.dart';

class UserMakeownController extends GetxController {
  int outdoorservice = 0;
  int price = 000;
  int photoPrice = 00;
  String? userName;
  String? phone;

  int numberOfPeople = 000;
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
  List<bool> foodcheckList = [];
  List<bool> soundcheckList = [];
  List<bool> decorationcheckList = [];
  TextEditingController peopleCtrl = TextEditingController();
  TextEditingController numberPhotoCtrl = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String? senderEmail;

  updateExpanded(int index) {
    if (isExpanded[index]) {
      isExpanded[index] = false;
    } else {
      isExpanded[index] = true;
    }
    update();
  }

  updatetime(TimeOfDay newtime) {
    selectedTime = newtime;
    update();
    print(selectedTime);
  }

//________________________________UPDATE DATE
  updateDate(DateTime newdate) {
    selectedDate = newdate;
    update();
    print(selectedDate);
  }

  getPackageDetail(String email) async {
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
    fillCheckBox();
  }

  fillCheckBox() {
    for (int i = 0; i < foodNameList.length; i++) {
      foodcheckList.add(false);
    }
    for (int i = 0; i < djList.length; i++) {
      soundcheckList.add(false);
    }
    for (int i = 0; i < decorationList.length; i++) {
      decorationcheckList.add(false);
    }
  }

  updatePhotoPrice() {
    print('calling');
    int ttlPhotoPrice = int.parse(numberPhotoCtrl.text) * photoPrice;
    price = price + ttlPhotoPrice;
    update();
  }

  updatecheck(int index, String type, bool val, int pricee) {
    int ttlpeople = int.parse(peopleCtrl.text);
    int ttlprice = 0;
    if (type == 'food') {
      ttlprice = ttlpeople * pricee;
    } else {
      ttlprice = pricee;
    }

    if (val) {
      price = price + ttlprice;
    } else {
      price = price - ttlprice;
    }
    if (type == 'food') {
      foodcheckList[index] = val;
      update();
    }
    if (type == 'dj') {
      soundcheckList[index] = val;
      update();
    }
    if (type == 'decoration') {
      decorationcheckList[index] = val;
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    callingFunction();
  }

  callingFunction() async {
    await getEmail();
    await getUserDetail();
  }

  getUserDetail() async {
    var db = FirebaseFirestore.instance.collection('user');
    print(senderEmail);
    try {
      var response = await db
          .where('email', isEqualTo: senderEmail)
          .get()
          .then((QuerySnapshot querySnapshot) => {
                querySnapshot.docs.forEach((doc) async {
                  print(doc['name']);
                  userName = doc['name'];
                  phone = doc['phone'];
                  update();
                }),
              });
    } catch (e) {
      print('Error $e');
    }
  }

  //___________________GET EMAIL
  getEmail() async {
    final ref = await SharedPreferences.getInstance();
    senderEmail = ref.getString('email');
  }

  postMakeownOffer(String recieverEmail) async {
    String date =
        '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}';
    String time = '${selectedTime.hour}:${selectedTime.minute}';
    //food
    List<String> food = [];
    for (int i = 0; i < foodNameList.length; i++) {
      if (foodcheckList[i] == true) {
        food.add(foodNameList[i]);
      }
    }
    //decoration
    List<String> decoration = [];
    for (int i = 0; i < decorationList.length; i++) {
      if (decorationcheckList[i] == true) {
        decoration.add(decorationList[i]);
      }
    }
    //dj
    List<String> dj = [];
    for (int i = 0; i < djList.length; i++) {
      if (soundcheckList[i] == true) {
        dj.add(djList[i]);
      }
    }
    var data = {
      'price': price,
      'foodlist': food,
      'decorationList': decoration,
      'djList': dj,
      'date': date,
      'time': time,
      'package': 'makeown',
      'senderEmail': senderEmail,
      'recieverEmail': recieverEmail,
      'status': 'new',
      'name': userName,
      'phone': phone
    };

    var result =
        await FirebaseFirestore.instance.collection('request').add(data);
    if (result.id != null) {
      snackBar('Congratulations...!', 'Request Submit Successfully..',
          Icons.done_all);
      navigatorScreen(const UserRequest());
    } else {
      snackBar('Oh No...', 'Something Went Wrong !!!', Icons.error);
    }
  }
}
