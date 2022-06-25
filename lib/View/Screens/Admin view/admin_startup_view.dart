import 'package:flutter/material.dart';
import 'package:occasional_pockets/View/Screens/Admin%20view/admin_home_view.dart';
import 'package:occasional_pockets/linked_screens.dart';
import '../../../Controller/admin_home_cotroller.dart';

class AdminStartUpView extends StatelessWidget {
  const AdminStartUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AdminHomeController adminCrl = Get.put(AdminHomeController());
    return Scaffold(
      body: GetBuilder<AdminHomeController>(builder: (controller) {
        if (controller.index == 1) {
          return const AdminHomeView();
        }
        if (controller.index == 2) {
          return const Center(
            child: Text('Admin Service View'),
          );
        }
        if (controller.index == 3) {
          return const Center(
            child: Text('Admin Request Screen'),
          );
        } else {
          return const Center(
            child: Text('Admin Setting Screen'),
          );
        }
      }),
      bottomNavigationBar: const NavigationPortion(),
    );
  }
}

//____________________________________________________BOTTOM NAVIGATION

class NavigationPortion extends StatelessWidget {
  const NavigationPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminHomeController>(builder: (controller) {
      return Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            )),
        child: Align(
          alignment: Alignment.center,
          child: Row(children: [
            //___________________________________ONE

            Expanded(
              child: InkWell(
                onTap: () {
                  controller.updateindex(1);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.home_outlined,
                      color: Colors.white,
                      size: 25,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      'Home',
                      style: GoogleFonts.josefinSans(
                          fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),

            //___________________________________Two

            Expanded(
              child: InkWell(
                onTap: () {
                  controller.updateindex(2);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.edit_calendar_rounded,
                      color: Colors.white,
                      size: 25,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      'Manage',
                      style: GoogleFonts.josefinSans(
                          fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),

            //___________________________________Three

            Expanded(
              child: InkWell(
                onTap: () {
                  controller.updateindex(3);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.notifications_rounded,
                      color: Colors.white,
                      size: 25,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      'Request',
                      style: GoogleFonts.josefinSans(
                          fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),

            //___________________________________FOUR

            Expanded(
              child: InkWell(
                onTap: () {
                  controller.updateindex(4);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 25,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      'Profile',
                      style: GoogleFonts.josefinSans(
                          fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      );
    });
  }
}
