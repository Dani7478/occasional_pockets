import 'package:occasional_pockets/linked_screens.dart';

import '../../View/Common Widgets/snack_bar.dart';
import '../../View/Screens/Admin view/admin_startup_view.dart';

class MakeOwnFormController extends GetxController {
  TextEditingController numberofPeopleCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController outdoorCtrl = TextEditingController();
  TextEditingController PhotoCtrl = TextEditingController();
  List<TextEditingController> foodTextFieldList = [
    TextEditingController(),
  ];
  List<TextEditingController> foodPriceTextFieldList = [
    TextEditingController(),
  ];
  List<TextEditingController> soundTextFieldList = [
    TextEditingController(),
  ];
  List<TextEditingController> soundPriceTextFieldList = [
    TextEditingController(),
  ];
  List<TextEditingController> decorationTextFieldList = [
    TextEditingController(),
  ];
  List<TextEditingController> decorationPriceTextFieldList = [
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
    foodTextFieldList.add(TextEditingController());
    foodPriceTextFieldList.add(TextEditingController());
    update();
  }

  updatesoundTextFieldList() {
    soundTextFieldList.add(TextEditingController());
    soundPriceTextFieldList.add(TextEditingController());

    update();
  }

  updatedecorationTextFieldList() {
    decorationTextFieldList.add(TextEditingController());
    decorationPriceTextFieldList.add(TextEditingController());
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
    List<int> foodPriceList = [];
    List<String> decorationList = [];
    List<int> decorationPriceList = [];
    List<String> soundList = [];
    List<int> soundPriceList = [];
    for (int i = 0; i < foodTextFieldList.length; i++) {
      foodList.add(foodTextFieldList[i].text);
      foodPriceList.add(int.parse(foodPriceTextFieldList[i].text));
    }
    for (int i = 0; i < decorationTextFieldList.length; i++) {
      decorationList.add(decorationTextFieldList[i].text);
      decorationPriceList.add(int.parse(decorationPriceTextFieldList[i].text));
    }
    for (int i = 0; i < soundTextFieldList.length; i++) {
      soundList.add(soundTextFieldList[i].text);
      soundPriceList.add(int.parse(soundPriceTextFieldList[i].text));
    }

    var data = {
      'email': email,
      'package': 'makeown',
      'photoprice': int.parse(PhotoCtrl.text),
      'foodList': foodList,
      'foodimages': foodImageList,
      'foodPriceList': foodPriceList,
      'djList': soundList,
      'djImage': soundImageList,
      'djPriceList': soundPriceList,
      'decorationList': decorationList,
      'decorationImages': decorationImageList,
      'decorationPriceList': decorationPriceList,
      'outdoorprice': int.parse(outdoorCtrl.text),
    };

    var user = FirebaseFirestore.instance.collection('package');
    var result = await user.add(data);
    if (result.id != null) {
      snackBar('Message', 'MakeOwn Package Added Successfully',
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
