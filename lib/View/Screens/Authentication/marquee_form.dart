// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:occasional_pockets/Controller/marquee_form_controller.dart';
import 'package:occasional_pockets/linked_screens.dart';

class MarqueeFormView extends StatelessWidget {
  const MarqueeFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MarqueeFromController controller = Get.put(MarqueeFromController());
    return const Scaffold(body: SafeArea(child: MainBodyPortion()));
  }
}

//__________________MAIN BODY PORTION
class MainBodyPortion extends StatelessWidget {
  const MainBodyPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          ImagePortion(),
          MarqueeNamePortion(),
          MarqueeCityPortion(),
          MarqueeAddressPortion(),
          SubmitButtonPortion(),
        ],
      ),
    );
  }
}

//_________________IMAGE PORTION
class ImagePortion extends StatelessWidget {
  const ImagePortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarqueeFromController>(builder: (controller) {
      if (controller.image == null) {
        return unselectedImageContainer();
      }
      return selectedImageContainer();
    });
  }

  unselectedImageContainer() {
    return GetBuilder<MarqueeFromController>(builder: (controller) {
      return InkWell(
        onTap: () async {
          String imageData = await selectImage();
          controller.updateImage(imageData);
        },
        child: Container(
            height: 250,
            width: double.infinity,
            color: primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.camera_alt,
                  size: 50,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text('Select Image',
                    style: GoogleFonts.josefinSans(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600)),
              ],
            )),
      );
    });
  }

  selectedImageContainer() {
    return GetBuilder<MarqueeFromController>(builder: (controller) {
      return InkWell(
        onTap: () async {
          String imageData = await selectImage();
          controller.updateImage(imageData);
        },
        child: Container(
            height: 250,
            width: double.infinity,
            color: primaryColor,
            child: Image.memory(
              base64.decode(controller.image.toString()),
              fit: BoxFit.fill,
            )),
      );
    });
  }
}

//__________________Marquee Name Portion
class MarqueeNamePortion extends StatelessWidget {
  const MarqueeNamePortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarqueeFromController>(builder: (controller) {
      return selectMarqueeName();
    });
  }

  selectMarqueeName() {
    return GetBuilder<MarqueeFromController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 111, 199, 240),
                borderRadius: BorderRadius.circular(10)),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: controller.marqueeName,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: 'Enter Marquee Name',
                      border: InputBorder.none,
                      hintStyle: GoogleFonts.josefinSans(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                  style: GoogleFonts.josefinSans(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800),
                ),
              ),
            )),
      );
    });
  }
}

//__________________Marquee City Portion
class MarqueeCityPortion extends StatelessWidget {
  const MarqueeCityPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarqueeFromController>(builder: (controller) {
      return selectMarqueeCity();
    });
  }

  selectMarqueeCity() {
    return GetBuilder<MarqueeFromController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 111, 199, 240),
                borderRadius: BorderRadius.circular(10)),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: controller.marqueeCity,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: 'Enter City Name',
                      border: InputBorder.none,
                      hintStyle: GoogleFonts.josefinSans(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                  style: GoogleFonts.josefinSans(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800),
                ),
              ),
            )),
      );
    });
  }
}

//__________________Marquee ADDRESS Portion
class MarqueeAddressPortion extends StatelessWidget {
  const MarqueeAddressPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarqueeFromController>(builder: (controller) {
      return selectMarqueeAddress();
    });
  }

  selectMarqueeAddress() {
    return GetBuilder<MarqueeFromController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 111, 199, 240),
                borderRadius: BorderRadius.circular(10)),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: controller.marqueeAddress,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: 'Enter Marquee Address',
                      border: InputBorder.none,
                      hintStyle: GoogleFonts.josefinSans(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                  style: GoogleFonts.josefinSans(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800),
                ),
              ),
            )),
      );
    });
  }
}

//________________________________________________SUBMIT BUTTON
class SubmitButtonPortion extends StatelessWidget {
  const SubmitButtonPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarqueeFromController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: InkWell(
          onTap: () async {
            await controller.postData();
          },
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                color: primaryColor, borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Text('Next',
                  style: GoogleFonts.josefinSans(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w500)),
            ),
          ),
        ),
      );
    });
  }
}
