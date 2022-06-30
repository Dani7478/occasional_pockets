// ignore_for_file: avoid_print, unused_local_variable
import 'package:occasional_pockets/linked_screens.dart';
import '../../View/Common Widgets/snack_bar.dart';
import '../../View/Screens/Admin view/admin_startup_view.dart';

class BasicFormController extends GetxController {
  TextEditingController numberofPeopleCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController PhotoCtrl = TextEditingController();
  List<TextEditingController> foodTextFieldList = [
    TextEditingController(),
  ];
  List<TextEditingController> soundTextFieldList = [
    TextEditingController(),
  ];
  List<TextEditingController> decorationTextFieldList = [
    TextEditingController(),
  ];

  List<String> foodImageList = [];
  List<String> soundImageList = [];
  List<String> decorationImageList = [];
  List<String> btnfoodimageList = ['Select Image'];
  List<String> btnSoundimageList = ['Select Image'];
  List<String> btnDecorationimageList = ['Select Image'];
  String email = 'Pending...';

  updatefoodTextFieldList() {
    print('Calling');
    foodTextFieldList.add(TextEditingController());
    update();
    print(foodTextFieldList.length);
  }

  updatesoundTextFieldList() {
    soundTextFieldList.add(TextEditingController());
    update();
  }

  updatedecorationTextFieldList() {
    decorationTextFieldList.add(TextEditingController());
    update();
  }

  addFoodImage(String imageUrl) {
    foodImageList.add(imageUrl);
    btnfoodimageList.last = 'selected';
    btnfoodimageList.add('Select Image');
    update();
  }

  addSoundImage(String imageUrl) {
    soundImageList.add(imageUrl);
    btnSoundimageList.last = 'selected';
    btnSoundimageList.add('Select Image');
    update();
  }

  addDecorationImage(String imageUrl) {
    decorationImageList.add(imageUrl);
    btnDecorationimageList.last = 'selected';
    btnDecorationimageList.add('Select Image');
    update();
  }

  uploadData() async {
    List<String> foodList = [];
    List<String> decorationList = [];
    List<String> soundList = [];
    for (int i = 0; i < foodTextFieldList.length; i++) {
      foodList.add(foodTextFieldList[i].text);
    }
    for (int i = 0; i < decorationTextFieldList.length; i++) {
      decorationList.add(decorationTextFieldList[i].text);
    }
    for (int i = 0; i < soundTextFieldList.length; i++) {
      soundList.add(soundTextFieldList[i].text);
    }

    var data = {
      'email': email,
      'package': 'basic',
      'people': int.parse(numberofPeopleCtrl.text),
      'price': int.parse(priceCtrl.text),
      'photo': int.parse(PhotoCtrl.text),
      'foodList': foodList,
      'foodimages': foodImageList,
      'djList': soundList,
      'djImage': soundImageList,
      'decorationList': decorationList,
      'decorationImages': decorationImageList
    };

    var user = FirebaseFirestore.instance.collection('package');
    var id = await user.add(data);
    if (id != null) {
      snackBar('Message', 'Basic Package Added Successfully',
          Icons.done_outline_outlined);
      navigatorScreen(const AdminStartUpView());
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getEmail();
  }

  getEmail() async {
    final ref = await SharedPreferences.getInstance();
    email = ref.getString('email')!;
    print(email);
    update();
  }
}
