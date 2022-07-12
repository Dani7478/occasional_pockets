// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:io';
import 'package:occasional_pockets/linked_screens.dart';

class UserMakeownPackageDetail extends StatefulWidget {
  UserMakeownPackageDetail({Key? key, required this.email}) : super(key: key);
  String email;

  @override
  State<UserMakeownPackageDetail> createState() =>
      _UserMakeownPackageDetailState();
}

UserMakeownController usermakeownCtrl = Get.put(UserMakeownController());

class _UserMakeownPackageDetailState extends State<UserMakeownPackageDetail> {
  @override
  void initState() {
    super.initState();
    usermakeownCtrl.getPackageDetail(widget.email);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserMakeownController usermakeownCtrl = Get.put(UserMakeownController());
    return Scaffold(
        appBar: AppBar(
          title: titleText,
          shape: appBarDecoration,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const TopPriceHeader(),
                ServicePortion(
                    email: widget.email, controller: usermakeownCtrl),
              ],
            ),
          ),
        ));
  }
}

//______________________________________________TOP HEADER
class TopPriceHeader extends StatelessWidget {
  const TopPriceHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<UserMakeownController>(builder: (controller) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                height: 45,
                width: 150,
                decoration: BoxDecoration(
                    //color: const Color.fromARGB(255, 111, 199, 240),
                    borderRadius: BorderRadius.circular(10)),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: controller.peopleCtrl,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: '000',
                          border: InputBorder.none,
                          hintStyle: GoogleFonts.josefinSans(
                            color: Colors.redAccent,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          )),
                      style: GoogleFonts.josefinSans(
                          color: Colors.redAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                )),
            Text(
              "Price: ${controller.price} PKR",
              style: GoogleFonts.josefinSans(
                  fontSize: 18,
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
      );
    });
  }
}

//_____________________________________________SERVICE PORTION
class ServicePortion extends StatelessWidget {
  ServicePortion({Key? key, required this.email, required this.controller})
      : super(key: key);

  String email;
  UserMakeownController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          const FoodPortion(),
          const DJPortion(),
          const DecorationPortion(),
          const PhotoGraphyPortion(),
          OrderNowButton(
              package: 'makeown', controller: controller, email: email)
        ],
      ),
    );
  }
}

//___________________FOOD
class FoodPortion extends StatelessWidget {
  const FoodPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserMakeownController>(builder: (controller) {
      bool expand = controller.isExpanded[0];
      return Container(
        height: expand == false ? 80 : 400,
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            )),
        child: Align(
            alignment: expand == false ? Alignment.center : Alignment.topLeft,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.food_bank_outlined,
                      size: 25, color: Colors.white),
                  title: Text(
                    "Food Services",
                    style: GoogleFonts.josefinSans(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w800),
                  ),
                  subtitle: Text(
                    "All foods services Detail",
                    style: GoogleFonts.roboto(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w300),
                  ),
                  trailing: InkWell(
                    onTap: () {
                      controller.updateExpanded(0);
                    },
                    child: const Icon(Icons.arrow_right_rounded,
                        size: 25, color: Colors.white),
                  ),
                ),
                expand == true
                    ? Expanded(
                        child: ListView.builder(
                            itemCount: controller.foodNameList.length,
                            itemBuilder: (context, index) {
                              String foodName = controller.foodNameList[index];
                              String image = controller.foodImageList[index];
                              int price = controller.foodPriceList[index];
                              bool check = controller.foodcheckList[index];
                              return serviceCard(
                                  image, foodName, price, check, index, 'food');
                            }))
                    : Container(),
              ],
            )),
      );
    });
  }
}

//_______________________________DJ PORTION
class DJPortion extends StatelessWidget {
  const DJPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserMakeownController>(builder: (controller) {
      bool expand = controller.isExpanded[1];
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          height: expand == false ? 80 : 400,
          decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )),
          child: Align(
              alignment: expand == false ? Alignment.center : Alignment.topLeft,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.queue_music_outlined,
                        size: 25, color: Colors.white),
                    title: Text(
                      "Sound Services",
                      style: GoogleFonts.josefinSans(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w800),
                    ),
                    subtitle: Text(
                      "DJ List that is available in function",
                      style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w300),
                    ),
                    trailing: InkWell(
                      onTap: () {
                        controller.updateExpanded(1);
                      },
                      child: const Icon(Icons.arrow_right_rounded,
                          size: 25, color: Colors.white),
                    ),
                  ),
                  expand == true
                      ? Expanded(
                          child: ListView.builder(
                              itemCount: controller.djList.length,
                              itemBuilder: (context, index) {
                                String djName = controller.djList[index];
                                String image = controller.djImageList[index];
                                int price = controller.djPriceList[index];
                                bool check = controller.soundcheckList[index];
                                return serviceCard(
                                    image, djName, price, check, index, 'dj');
                              }))
                      : Container(),
                ],
              )),
        ),
      );
    });
  }
}

//_______________________________DECORATION PORTION
class DecorationPortion extends StatelessWidget {
  const DecorationPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserMakeownController>(builder: (controller) {
      bool expand = controller.isExpanded[2];
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          height: expand == false ? 80 : 400,
          decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )),
          child: Align(
              alignment: expand == false ? Alignment.center : Alignment.topLeft,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.apartment_sharp,
                        size: 25, color: Colors.white),
                    title: Text(
                      "Decoration Sevices",
                      style: GoogleFonts.josefinSans(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w800),
                    ),
                    subtitle: Text(
                      "How look like Hall with Decoration",
                      style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w300),
                    ),
                    trailing: InkWell(
                      onTap: () {
                        controller.updateExpanded(2);
                      },
                      child: const Icon(Icons.arrow_right_rounded,
                          size: 25, color: Colors.white),
                    ),
                  ),
                  expand == true
                      ? Expanded(
                          child: ListView.builder(
                              itemCount: controller.decorationList.length,
                              itemBuilder: (context, index) {
                                String decoration =
                                    controller.decorationList[index];
                                String image =
                                    controller.decorationImageList[index];
                                int price =
                                    controller.decorationPriceList[index];
                                bool check =
                                    controller.decorationcheckList[index];
                                return serviceCard(image, decoration, price,
                                    check, index, 'decoration');
                              }))
                      : Container(),
                ],
              )),
        ),
      );
    });
  }
}

//_______________________________________PHOTOGRAPHY

class PhotoGraphyPortion extends StatelessWidget {
  const PhotoGraphyPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserMakeownController>(builder: (controller) {
      bool expand = controller.isExpanded[3];
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          height: expand == false ? 80 : 200,
          decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )),
          child: Align(
              alignment: expand == false ? Alignment.center : Alignment.topLeft,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.photo_camera_front,
                        size: 25, color: Colors.white),
                    title: Text(
                      "PhotoShoot Sevices",
                      style: GoogleFonts.josefinSans(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w800),
                    ),
                    subtitle: Text(
                      "We Provide Proffessional Photo Shoot",
                      style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w300),
                    ),
                    trailing: InkWell(
                      onTap: () {
                        controller.updateExpanded(3);
                      },
                      child: const Icon(Icons.arrow_right_rounded,
                          size: 25, color: Colors.white),
                    ),
                  ),
                  expand == true
                      ? Expanded(
                          child: ListView.builder(
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                int totalphoto = controller.photoPrice;
                                String image = 'images/photography.jpg';
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, left: 5, right: 5),
                                  child: Container(
                                    height: 90,
                                    decoration: const BoxDecoration(
                                        color: Color(0xfff95b3f0),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        )),
                                    child: Center(
                                      child: ListTile(
                                          leading: Container(
                                            child: Image.asset(
                                              image,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          title: Text(
                                            'Per Photo Price :$totalphoto',
                                            style: GoogleFonts.josefinSans(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          trailing: SizedBox(
                                            width: 50,
                                            child: TextFormField(
                                              onFieldSubmitted: (value) {
                                                controller.updatePhotoPrice();
                                              },
                                              controller:
                                                  controller.numberPhotoCtrl,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                  hintText: '00',
                                                  border: InputBorder.none,
                                                  hintStyle:
                                                      GoogleFonts.josefinSans(
                                                    color: Colors.redAccent,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                              style: GoogleFonts.josefinSans(
                                                  color: Colors.redAccent,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          )),
                                    ),
                                  ),
                                );
                              }))
                      : Container(),
                ],
              )),
        ),
      );
    });
  }
}

serviceCard(
  String productImage,
  String productName,
  int productPricr,
  bool check,
  int index,
  String type,
) {
  return GetBuilder<UserMakeownController>(builder: (controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
      child: Container(
        height: 90,
        decoration: const BoxDecoration(
            color: Color(0xfff95b3f0),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Center(
            child: ListTile(
                leading: Container(
                  child: Image.memory(
                    base64.decode(productImage.toString()),
                    fit: BoxFit.fill,
                  ),
                ),
                title: Text(
                  productName,
                  style: GoogleFonts.josefinSans(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w800),
                ),
                subtitle: Text(
                  '\$ $productPricr',
                  style: GoogleFonts.josefinSans(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w800),
                ),
                trailing: Checkbox(
                    value: check,
                    onChanged: (value) {
                      controller.updatecheck(index, type, value!, productPricr);
                    })),
          ),
        ),
      ),
    );
  });
}

class OrderNowButton extends StatelessWidget {
  OrderNowButton(
      {Key? key,
      required this.package,
      required this.controller,
      required this.email})
      : super(key: key);
  String package;
  UserMakeownController controller;
  String email;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
          color: primaryColor, borderRadius: BorderRadius.circular(10)),
      child: TextButton(
        onPressed: () {
          submitAlert(context, controller);
        },
        child: Text(
          'Order Now',
          style: GoogleFonts.josefinSans(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }

  submitAlert(BuildContext context, UserMakeownController controller) {
    return Get.defaultDialog(
        title: 'Order Now',
        titleStyle: GoogleFonts.josefinSans(
            fontSize: 18, color: Colors.redAccent, fontWeight: FontWeight.w800),
        backgroundColor: const Color.fromARGB(255, 220, 230, 248),
        radius: 5,
        content: Column(
          children: [
            //Date
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                onPressed: () {
                  selectDate(context);
                },
                child: Text(
                  'Select Date',
                  style: GoogleFonts.josefinSans(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),

            //time
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                onPressed: () {
                  selectTime(context);
                },
                child: Text(
                  'Select Time',
                  style: GoogleFonts.josefinSans(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),

            //submit order
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              width: 150,
              height: 40,
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                onPressed: () {
                  controller.postMakeownOffer(email);
                  Get.back();
                },
                child: Text(
                  'Submit Order',
                  style: GoogleFonts.josefinSans(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ));
  }

  selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: controller.selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != controller.selectedDate) {
      controller.updateDate(selected);
    }
  }

  selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: controller.selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != controller.selectedTime) {
      controller.updatetime(timeOfDay);
    }
  }
}

Widget titleText = Text(
  "Makeown Package",
  style: GoogleFonts.roboto(
      fontSize: 18, color: Colors.white, fontWeight: FontWeight.w800),
);
