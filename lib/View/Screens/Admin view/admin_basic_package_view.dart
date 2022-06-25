import 'package:occasional_pockets/Controller/admin_basic_controller.dart';
import 'package:occasional_pockets/linked_screens.dart';

class AdminBasicPackageView extends StatelessWidget {
  const AdminBasicPackageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AdminBasicController adminBasicCrl = Get.put(AdminBasicController());
    return Scaffold(
        appBar: AppBar(),
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Seats: 100',
            style: GoogleFonts.josefinSans(
                fontSize: 18,
                color: Colors.redAccent,
                fontWeight: FontWeight.w800),
          ),
          Text(
            "Price: \$500",
            style: GoogleFonts.josefinSans(
                fontSize: 18,
                color: Colors.redAccent,
                fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
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
    return GetBuilder<AdminBasicController>(builder: (controller) {
      bool expand = controller.isExpanded[0];
      return Container(
        height: expand == false ? 80 : 500,
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
                              String image = 'images/bariyani.jpg';
                              return foodCard(image, foodName);
                            }))
                    : Container(),
              ],
            )),
      );
    });
  }

  //___________________________FOOD CARD
  foodCard(String img, String foodName) {
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
        child: Center(
          child: ListTile(
            leading: Container(
              child: Image.asset(
                img,
                fit: BoxFit.fill,
              ),
            ),
            title: Text(
              foodName,
              style: GoogleFonts.josefinSans(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ),
    );
  }
}

//_______________________________DJ PORTION
class DJPortion extends StatelessWidget {
  const DJPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminBasicController>(builder: (controller) {
      bool expand = controller.isExpanded[1];
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          height: expand == false ? 80 : 300,
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
                                String image = 'images/djasad.jpg';
                                return soundCard(image, djName);
                              }))
                      : Container(),
                ],
              )),
        ),
      );
    });
  }

  //___________________________SOUND CARD
  soundCard(String img, String foodName) {
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
        child: Center(
          child: ListTile(
            leading: Container(
              child: Image.asset(
                img,
                fit: BoxFit.fill,
              ),
            ),
            title: Text(
              foodName,
              style: GoogleFonts.josefinSans(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ),
    );
  }
}
