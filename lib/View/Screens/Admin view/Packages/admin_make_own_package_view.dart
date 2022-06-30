import 'dart:convert';
import 'dart:io';
import 'package:occasional_pockets/linked_screens.dart';

class AdminMakeownPackageView extends StatelessWidget {
  const AdminMakeownPackageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AdminMakeownController adminBasicCrl = Get.put(AdminMakeownController());
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
                ServicePortion(),
                BottomPriceHeader(),
              ],
            ),
          ),
        ));
  }
}

//______________________________________________TOP HEADER
class BottomPriceHeader extends StatelessWidget {
  const BottomPriceHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<AdminMakeownController>(builder: (controller) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Center(
          child: Text(
            'Outdoor Service Charges: ${controller.outdoorservice}',
            style: GoogleFonts.josefinSans(
                fontSize: 18,
                color: Colors.redAccent,
                fontWeight: FontWeight.w800),
          ),
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
    return GetBuilder<AdminMakeownController>(builder: (controller) {
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
                              return serviceCard(image, foodName, price);
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
    return GetBuilder<AdminMakeownController>(builder: (controller) {
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
                                return serviceCard(image, djName, price);
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
    return GetBuilder<AdminMakeownController>(builder: (controller) {
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
                                return serviceCard(image, decoration, price);
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
    return GetBuilder<AdminMakeownController>(builder: (controller) {
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

serviceCard(String productImage, String productName, int productPricr) {
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
            trailing: Text(
              '\$ $productPricr',
              style: GoogleFonts.josefinSans(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget titleText = Text(
  "Makeown Package",
  style: GoogleFonts.roboto(
      fontSize: 18, color: Colors.white, fontWeight: FontWeight.w800),
);
