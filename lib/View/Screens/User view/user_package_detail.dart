import 'dart:convert';
import 'dart:io';
import 'package:occasional_pockets/Controller/AdminControllers/admin_basic_controller.dart';
import 'package:occasional_pockets/linked_screens.dart';
import 'package:rating_dialog/rating_dialog.dart';

class UserPackageDetailView extends StatefulWidget {
  UserPackageDetailView({Key? key, required this.email, required this.package})
      : super(key: key);
  String? email;
  String? package;

  @override
  State<UserPackageDetailView> createState() => _UserPackageDetailViewState();
}

class _UserPackageDetailViewState extends State<UserPackageDetailView> {
  UserPackageDetailController controller =
      Get.put(UserPackageDetailController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getPackageDetail(
        widget.email.toString(), widget.package.toString());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller = Get.put(UserPackageDetailController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.package!.toUpperCase(),
            style: GoogleFonts.roboto(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.w800),
          ),
          shape: appBarDecoration,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const TopPriceHeader(),
                ServicePortion(
                    package: widget.package.toString(), controller: controller),
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
    return GetBuilder<UserPackageDetailController>(builder: (controller) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Seats: ${controller.numberOfPeople}',
              style: GoogleFonts.josefinSans(
                  fontSize: 18,
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w800),
            ),
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
  ServicePortion({Key? key, required this.package, required this.controller})
      : super(key: key);
  String package;
  UserPackageDetailController controller;
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
          OrderNowButton(package: package, controller: controller),
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
    return GetBuilder<UserPackageDetailController>(builder: (controller) {
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
                              return serviceCard(image, foodName);
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
    return GetBuilder<UserPackageDetailController>(builder: (controller) {
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
                                return serviceCard(image, djName);
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
    return GetBuilder<UserPackageDetailController>(builder: (controller) {
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
                                return serviceCard(image, decoration);
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
    return GetBuilder<UserPackageDetailController>(builder: (controller) {
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
                                int totalphoto = controller.totalPhotos;
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
                                          'Toal Photo With DSLR : $totalphoto',
                                          style: GoogleFonts.josefinSans(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ),
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

class OrderNowButton extends StatelessWidget {
  OrderNowButton({Key? key, required this.package, required this.controller})
      : super(key: key);
  String package;
  UserPackageDetailController controller;
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

  submitAlert(BuildContext context, UserPackageDetailController controller) {
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
                  controller.postPackage(package);
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
