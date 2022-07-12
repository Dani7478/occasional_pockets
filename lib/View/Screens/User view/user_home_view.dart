// ignore_for_file: unused_local_variable, no_leading_underscores_for_local_identifiers, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:occasional_pockets/View/Screens/Admin%20view/Request/admin_feedback_view.dart';
import 'package:occasional_pockets/View/Screens/User%20view/user_packages_view.dart';
import 'package:occasional_pockets/View/Screens/User%20view/user_startup_view.dart';
import 'package:occasional_pockets/linked_screens.dart';
import 'package:rating_dialog/rating_dialog.dart';

class UserHomeView extends StatelessWidget {
  const UserHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserHomeController usrCtrl = Get.put(UserHomeController());
    return Scaffold(
      appBar: AppBar(
        title: const AppBarPortion(),
        shape: appBarDecoration,
      ),
      body: const MainPortion(),
    );
  }
}

//___________________________________________________APP BAR PORTION

class AppBarPortion extends StatelessWidget {
  const AppBarPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserHomeController>(builder: (controller) {
      return controller.isSearching == false
          ? Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.username,
                    style: GoogleFonts.josefinSans(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w800),
                  ),
                  InkWell(
                    onTap: () {
                      controller.updateSearch(true);
                    },
                    child:
                        const Icon(Icons.search, size: 25, color: Colors.white),
                  )
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 90,
                    child: TextFormField(
                      controller: controller.searchCtrl,
                      onChanged: (value) {
                        controller.updateList(value);
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'Search Marquee',
                          border: InputBorder.none,
                          hintStyle: GoogleFonts.josefinSans(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600)),
                      style: GoogleFonts.josefinSans(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: InkWell(
                      onTap: () {
                        controller.updateSearch(false);
                        controller.refreshList();
                        controller.searchCtrl.clear();
                      },
                      child: const Icon(Icons.cancel,
                          size: 25, color: Colors.white),
                    ),
                  )
                ],
              ),
            );
    });
  }
}

//_________________________________________________MAIN PORTION

class MainPortion extends StatelessWidget {
  const MainPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserHomeController>(builder: (controller) {
      return controller.marueeList.isEmpty
          ? const Loader()
          : ListView.builder(
              itemCount: controller.marueeList.length,
              itemBuilder: (context, index) {
                String name = controller.marueeList[index]['marqueeName'];
                String marqueeImage = controller.marueeList[index]['image'];
                String city = controller.marueeList[index]['marqueeCity'];
                String address = controller.marueeList[index]['marqueeAddress'];
                String email = controller.marueeList[index]['email'];
                bool checker = controller.liker[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Container(
                      height: 350,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            topRow(name, city),
                            imagePortion(marqueeImage),
                            addressportion(address),
                            FeedBackPortion(
                              name: name,
                              city: city,
                              address: address,
                              marqueeImage: marqueeImage,
                              email: email,
                              index: index,
                              controller: controller,
                              checker: checker,
                            )
                          ],
                        ),
                      )),
                );
              });
    });
  }

  //__________________top row
  topRow(String name, String city) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: GoogleFonts.josefinSans(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w900),
          ),
          Text(
            city,
            style: GoogleFonts.josefinSans(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  //______________image
  imagePortion(String marqueeImage) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      height: 200,
      child: Image.memory(
        base64.decode(marqueeImage.toString()),
        fit: BoxFit.fill,
      ),
    );
  }

  //____________address
  addressportion(String address) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        address,
        style: GoogleFonts.josefinSans(
            fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class FeedBackPortion extends StatelessWidget {
  FeedBackPortion({
    Key? key,
    required this.name,
    required this.city,
    required this.address,
    required this.marqueeImage,
    required this.email,
    required this.index,
    required this.controller,
    required this.checker,
  }) : super(key: key);
  String? name;
  String? city;
  String? address;
  String? marqueeImage;
  String? email;
  int? index;
  UserHomeController controller;
  bool checker;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserHomeController>(builder: (controller) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  controller.updateLiker(index!);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    checker == false
                        ? Text(
                            "Like",
                            style: GoogleFonts.josefinSans(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          )
                        : Text(
                            "Unlike",
                            style: GoogleFonts.josefinSans(
                                fontSize: 16,
                                color: Colors.redAccent,
                                fontWeight: FontWeight.w700),
                          ),
                    const SizedBox(
                      width: 3,
                    ),
                    const Icon(
                      Icons.heart_broken_rounded,
                      size: 15,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            //____comment
            Expanded(
              child: InkWell(
                onTap: () {
                  ratingDialogue(
                      context, marqueeImage!, controller, name!, email!);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Comment",
                      style: GoogleFonts.josefinSans(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    const Icon(
                      Icons.comment,
                      size: 15,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            //__________________seemore
            //____comment
            Expanded(
              child: InkWell(
                onTap: () {
                  navigatorScreen(UserPackageView(
                    email: email,
                    marqueename: name,
                  ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "See More",
                      style: GoogleFonts.josefinSans(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    const Icon(
                      Icons.mobile_screen_share_sharp,
                      size: 15,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  ratingDialogue(BuildContext context, String image,
      UserHomeController controller, String marqueeName, String recieverEmail) {
    final _dialog = RatingDialog(
      starColor: primaryColor,
      starSize: 25,
      initialRating: 1.0,
      title: const Text(
        'Marquee Feedback',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      message: const Text(
        'Please Add Marquee Rating',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
      image: Image.memory(
        base64.decode(image.toString()),
        fit: BoxFit.fill,
      ),
      submitButtonText: 'Submit',
      commentHint: 'Enter Feedback about marquee',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) async {
        print('rating: ${response.rating}, comment: ${response.comment}');
        int rate = response.rating.toInt();
        String feedback = response.comment;
        await controller.submitFeedBack(
            rate, feedback, marqueeName, recieverEmail);
        navigatorScreen(AdminFeedbackView(role: 'user'));
      },
    );

    showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) => _dialog,
    );
  }
}
