// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:geolocator/geolocator.dart';
import 'package:occasional_pockets/View/Common%20Widgets/snack_bar.dart';
import 'package:occasional_pockets/linked_screens.dart';
import 'package:geocoding/geocoding.dart';

class UserHomeController extends GetxController {
  int index = 1;
  String username = 'Pending...';
  String email = '';
  List marueeList = [];
  List doublicateMarqueeList = [];
  List<bool> liker = [];
  String? city;

  String Address = 'search';
  bool? serviceEnabled;
  LocationPermission? permission;

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    city = place.locality!.toLowerCase();
    print('Current City: $city');
  }

  bool isSearching = false;
  TextEditingController searchCtrl = TextEditingController();

  updateSearch(bool val) {
    isSearching = val;
    update();
  }

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
    await getMarquees();
    Position position = await _getGeoLocationPosition();
    await GetAddressFromLatLong(position);
    updatedList();
  }

  getEmail() async {
    print('Geting email...');
    final ref = await SharedPreferences.getInstance();
    email = ref.getString('email')!;
    print(email);
  }

  getName() async {
    print('Geting Name....');
    await FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) async {
                print('Fetching record...');
                username = doc['name'];
                update();
              }),
            });
  }

  getMarquees() async {
    print('Geting Marquees....');
    await FirebaseFirestore.instance
        .collection('marquee')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) async {
                print('Fetching record...');
                marueeList.add(doc);
                update();
              }),
            });
    for (int i = 0; i < marueeList.length; i++) {
      liker.add(false);
    }
  }

  submitFeedBack(int rate, String feedback, String marqueeName,
      String recieverEmail) async {
    var data = {
      'rate': rate,
      'feedback': feedback,
      'name': username,
      'marqueeName': marqueeName,
      'senderEmail': email,
      'recieverEmail': recieverEmail
    };
    var db = FirebaseFirestore.instance.collection('feedback');
    var result = await db.add(data);
    if (result.id != null) {
      snackBar(
          'Congratulation...!', 'FeedBack Added Successfully', Icons.done_all);
    }
  }

  updateList(String search) {
    print('Searching');
    List doublicateList = [];
    //  marueeList.clear();
    for (int i = 0; i < marueeList.length; i++) {
      String listcity = marueeList[i]['marqueeCity'].toString().toLowerCase();
      String listMarquee =
          marueeList[i]['marqueeName'].toString().toLowerCase();
      String searchCity = search.toLowerCase();
      print('$listcity : $searchCity');
      if (listcity.contains(searchCity) || listMarquee.contains(searchCity)) {
        print('enter');
        doublicateList.add(marueeList[i]);
      }
    }
    print('Searching Done');
    marueeList = doublicateList;
    update();
  }

  refreshList() {
    print(doublicateMarqueeList.length);
    marueeList = doublicateMarqueeList;
    update();
    print('Refresh Done');
  }

  updatedList() {

    //rwp, lhr, mul, kar
    List doublicate = [];
    for (int i = 0; i < marueeList.length; i++) {
      if (marueeList[i]['marqueeCity'].toString().toLowerCase() == city) {
        print('Enterd');
        doublicate.add(marueeList[i]);
        marueeList.removeAt(i);
      }
    }

    for (int i = 0; i < marueeList.length; i++) {
      doublicate.add(marueeList[i]);
    }
    marueeList.clear();
    marueeList = doublicate;
    print('Location Done');
    print(marueeList.length);
    doublicateMarqueeList = marueeList;
    update();
  }

  updateLiker(int index) {
    if (liker[index] == true) {
      liker[index] = false;
    } else {
      liker[index] = true;
    }
    update();
  }
}
