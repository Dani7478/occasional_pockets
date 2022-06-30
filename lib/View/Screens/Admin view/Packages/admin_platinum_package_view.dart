import 'dart:convert';
import 'dart:io';

import 'package:occasional_pockets/Controller/AdminControllers/admin_basic_controller.dart';
import 'package:occasional_pockets/linked_screens.dart';

class AdminPlatinumPackageView extends StatelessWidget {
  const AdminPlatinumPackageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AdminPlatinumController adminBasicCrl = Get.put(AdminPlatinumController());
    return Scaffold(
        appBar: AppBar(
          title: titleText,
          shape: appBarDecoration,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: const [
                TopPriceHeader(),
                ServicePortion(),
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
    return GetBuilder<AdminPlatinumController>(builder: (controller) {
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
              "Price: \$ ${controller.price}",
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
  const ServicePortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: const [
          FoodPortion(),
          DJPortion(),
          DecorationPortion(),
          PhotoGraphyPortion()
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
    return GetBuilder<AdminPlatinumController>(builder: (controller) {
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
    return GetBuilder<AdminPlatinumController>(builder: (controller) {
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
    return GetBuilder<AdminPlatinumController>(builder: (controller) {
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
    return GetBuilder<AdminPlatinumController>(builder: (controller) {
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

Widget titleText = Text(
  "Platinum Package",
  style: GoogleFonts.roboto(
      fontSize: 18, color: Colors.white, fontWeight: FontWeight.w800),
);
