// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print, unused_local_variable, unnecessary_null_comparison
import 'package:occasional_pockets/View/Common%20Widgets/snack_bar.dart';
import 'package:occasional_pockets/View/Screens/User%20view/user_request_view.dart';
import 'package:occasional_pockets/linked_screens.dart';

class UserPackageDetailController extends GetxController {
  int price = 000;
  int numberOfPeople = 000;
  String? senderEmail;
  String? recieverEmail;
  List foodNameList = [];
  List djList = [];
  List decorationList = [];
  List<bool> isExpanded = [false, false, false, false, false];
  int totalPhotos = 15;
  List foodImageList = [];
  List decorationImageList = [];
  List djImageList = [];
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String? userName;
  String? phone;

//_____________________________UPDATE EXPANDED
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

//_______________________________________GET PKG DETAIL
  getPackageDetail(String email, String pkgType) async {
    var db = FirebaseFirestore.instance.collection('package');
    recieverEmail = email;
    print(email);
    try {
      var response = await db
          .where('email', isEqualTo: email)
          .where('package', isEqualTo: pkgType)
          .get()
          .then((QuerySnapshot querySnapshot) => {
                querySnapshot.docs.forEach((doc) async {
                  print('Fetching Data....');
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

  //______________________________________________POST PACKAGE
  postPackage(String pkg) async {
    String date =
        '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}';
    String time = '${selectedTime.hour}:${selectedTime.minute}';

    var data = {
      'senderEmail': senderEmail,
      'recieverEmail': recieverEmail,
      'name': userName,
      'phone': phone,
      'package': pkg,
      'date': date,
      'time': time,
      'status': 'new',
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

  @override
  void onInit() {
    super.onInit();
    callingFunction();
  }

  callingFunction() async {
    await getEmail();
    await getUserDetail();
  }

  //___________________GET EMAIL
  getEmail() async {
    final ref = await SharedPreferences.getInstance();
    senderEmail = ref.getString('email');
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
}
