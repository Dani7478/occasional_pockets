import 'package:occasional_pockets/Controller/AdminControllers/admin_home_cotroller.dart';
import 'package:occasional_pockets/View/Screens/Admin%20view/Manage/basic_package_form_view.dart';
import 'package:occasional_pockets/View/Screens/Admin%20view/Manage/makeown_package_form_view.dart';
import 'package:occasional_pockets/View/Screens/Admin%20view/Manage/platinum_package_form_view.dart';
import 'package:occasional_pockets/View/Screens/Admin%20view/Manage/premium_package_form_view.dart';
import 'package:occasional_pockets/linked_screens.dart';

AdminHomeController adminCrl = Get.put(AdminHomeController());

class AdminManageView extends StatelessWidget {
  const AdminManageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(45),
          child: AppBar(
            bottomOpacity: 25,
            backgroundColor: primaryColor,
            automaticallyImplyLeading: false,
            elevation: 0,
            title: const AppBarPortion(),
            shape: appBarDecoration,
          ),
        ),
        body: const MainBodyPortion());
  }
}

//___________________________________________________APP BAR PORTION

class AppBarPortion extends StatelessWidget {
  const AppBarPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Manage Your Pakages',
            style: GoogleFonts.josefinSans(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.w800),
          ),
          InkWell(
            onTap: () {},
            child: const Icon(Icons.search, size: 25, color: Colors.white),
          )
        ],
      ),
    );
  }
}

//____________________________________________________________BODY PORTION

class MainBodyPortion extends StatelessWidget {
  const MainBodyPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const Divider(
          //    thickness: 1,
          //   color: Colors.blue,
          //  ),
          Row(
            children: [
              gridCard(size, 'Basic Package', 'For Lower Class Users',
                  Icons.battery_0_bar),
              gridCard(size, 'Premium Package', 'For Middle Class Users',
                  Icons.workspace_premium_outlined),
            ],
          ),
          Row(
            children: [
              gridCard(size, 'platinum Package', 'For 5Star Class Users',
                  Icons.airplanemode_on_rounded),
              gridCard(size, 'Make Own', 'Make own Offer ',
                  Icons.type_specimen_rounded),
            ],
          ),
          // morePortion(size, 'More', 'See More Detail About Package',
          //     Icons.type_specimen_rounded),
        ],
      ),
    );
  }

  //___________________________________________________________GRID CARD
  gridCard(Size size, String title, String subtitle, IconData icon) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (title == 'Basic Package') {
            navigatorScreen(const BasicPackageFormView());
          }
          if (title == 'Premium Package') {
            navigatorScreen(const PremiumPackageFormView());
          }
          if (title == 'platinum Package') {
            navigatorScreen(const PlatinumPackageFormView());
          }
          if (title == 'Make Own') {
            navigatorScreen(const MakeownPackageFormView());
          }
        },
        child: Container(
          margin: const EdgeInsets.only(left: 5, right: 5, top: 12),
          height: size.height * 0.25,
          decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: GoogleFonts.josefinSans(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 3,
              ),
              Icon(icon, size: 45, color: Colors.white),
              const SizedBox(
                height: 6,
              ),
              Container(
                height: 50,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    subtitle,
                    style: GoogleFonts.josefinSans(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //_________________________________________MORE DETAIL

  morePortion(Size size, String title, String subtitle, IconData icon) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 5, right: 5, top: 12, bottom: 10),
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: GoogleFonts.josefinSans(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 6,
            ),
            Icon(icon, size: 45, color: Colors.white),
            const SizedBox(
              height: 6,
            ),
            Container(
              // height: 50,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  subtitle,
                  style: GoogleFonts.josefinSans(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
