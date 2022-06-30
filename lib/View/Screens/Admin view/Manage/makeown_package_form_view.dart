import 'package:occasional_pockets/linked_screens.dart';

class MakeownPackageFormView extends StatelessWidget {
  const MakeownPackageFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    MakeOwnFormController basicFormCrl = Get.put(MakeOwnFormController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: titleText,
        shape: appBarDecoration,
      ),
      body: const MainBodyPortion(),
    );
  }
}

class MainBodyPortion extends StatelessWidget {
  const MainBodyPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            whichPortion('Food Detail'),
            foodPortion(),
            whichPortion('DJ Detail'),
            soundPortion(),
            whichPortion('Decoration Detail'),
            decorationPortion(),
            whichPortion('Photography'),
            photoGraphyPortion(),
            whichPortion('OutDoor'),
            outdoorPortion(),
            submitButton(),
          ],
        ),
      ),
    );
  }

//_______________________________DIVIDER
  whichPortion(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(children: [
        const Expanded(child: Divider()),
        Text(
          ' $name ',
          style: GoogleFonts.roboto(
              fontSize: 14, color: Colors.black, fontWeight: FontWeight.w800),
        ),
        const Expanded(child: Divider()),
      ]),
    );
  }
}

//______________________________LOGIN BUTTON
submitButton() {
  return GetBuilder<MakeOwnFormController>(builder: (controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: InkWell(
        onTap: () {
          controller.uploadData();
        },
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              color: primaryColor, borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Text('Submit',
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

//___________________________________FOOD PORTION
foodPortion() {
  return GetBuilder<MakeOwnFormController>(builder: (controller) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.foodTextFieldList.length,
        itemBuilder: (context, index) {
          int lastIndex = controller.foodTextFieldList.length;
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Column(
                children: [
                  Container(
                      height: 45,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 111, 199, 240),
                          borderRadius: BorderRadius.circular(10)),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            controller: controller.foodTextFieldList[index],
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: 'Enter Food ${index + 1} Name',
                                border: InputBorder.none,
                                hintStyle: GoogleFonts.josefinSans(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                                suffixIcon: index == lastIndex - 1
                                    ? InkWell(
                                        onTap: () {
                                          if (controller
                                                  .btnfoodimageList[index] ==
                                              'selected') {
                                            controller
                                                .updatefoodTextFieldList();
                                          }
                                        },
                                        child: const Icon(Icons.add))
                                    : const SizedBox(
                                        height: 0,
                                        width: 0,
                                      )),
                            style: GoogleFonts.josefinSans(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 70,
                        child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 111, 199, 240),
                                borderRadius: BorderRadius.circular(10)),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: TextFormField(
                                  controller:
                                      controller.foodPriceTextFieldList[index],
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Food ${index + 1} Price',
                                    border: InputBorder.none,
                                    hintStyle: GoogleFonts.josefinSans(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  style: GoogleFonts.josefinSans(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                            )),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          flex: 30,
                          child: Container(
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(8)),
                            height: 43,
                            child: TextButton(
                              onPressed: () async {
                                String image = await selectImage();
                                controller.addFoodImage(image);
                              },
                              child: Text(controller.btnfoodimageList[index],
                                  style: GoogleFonts.josefinSans(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ))
                    ],
                  )
                ],
              ));
        });
  });
}

//___________________________________SOUND PORTION
soundPortion() {
  return GetBuilder<MakeOwnFormController>(builder: (controller) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.soundTextFieldList.length,
        itemBuilder: (context, index) {
          int lastIndex = controller.soundTextFieldList.length;
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Column(
                children: [
                  Container(
                      height: 45,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 111, 199, 240),
                          borderRadius: BorderRadius.circular(10)),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            controller: controller.soundTextFieldList[index],
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: 'Enter Dj ${index + 1} Name',
                                border: InputBorder.none,
                                hintStyle: GoogleFonts.josefinSans(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                                suffixIcon: index == lastIndex - 1
                                    ? InkWell(
                                        onTap: () {
                                          if (controller
                                                  .btnSoundimageList[index] ==
                                              'selected') {
                                            controller
                                                .updatesoundTextFieldList();
                                          }
                                        },
                                        child: const Icon(Icons.add))
                                    : const SizedBox(
                                        height: 0,
                                        width: 0,
                                      )),
                            style: GoogleFonts.josefinSans(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 70,
                        child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 111, 199, 240),
                                borderRadius: BorderRadius.circular(10)),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: TextFormField(
                                  controller:
                                      controller.soundPriceTextFieldList[index],
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Dj ${index + 1} Price',
                                    border: InputBorder.none,
                                    hintStyle: GoogleFonts.josefinSans(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  style: GoogleFonts.josefinSans(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                            )),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          flex: 30,
                          child: Container(
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(8)),
                            height: 43,
                            child: TextButton(
                              onPressed: () async {
                                String image = await selectImage();
                                controller.addSoundImage(image);
                              },
                              child: Text(controller.btnSoundimageList[index],
                                  style: GoogleFonts.josefinSans(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ))
                    ],
                  )
                ],
              ));
        });
  });
}

//___________________________________DECORATION PORTION
decorationPortion() {
  return GetBuilder<MakeOwnFormController>(builder: (controller) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.decorationTextFieldList.length,
        itemBuilder: (context, index) {
          int lastIndex = controller.decorationTextFieldList.length;
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Column(
                children: [
                  Container(
                      height: 45,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 111, 199, 240),
                          borderRadius: BorderRadius.circular(10)),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            controller:
                                controller.decorationTextFieldList[index],
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: 'Enter Decoration ${index + 1} Name',
                                border: InputBorder.none,
                                hintStyle: GoogleFonts.josefinSans(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                                suffixIcon: index == lastIndex - 1
                                    ? InkWell(
                                        onTap: () {
                                          if (controller.btnDecorationimageList[
                                                  index] ==
                                              'selected') {
                                            controller
                                                .updatedecorationTextFieldList();
                                          }
                                        },
                                        child: const Icon(Icons.add))
                                    : const SizedBox(
                                        height: 0,
                                        width: 0,
                                      )),
                            style: GoogleFonts.josefinSans(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 70,
                        child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 111, 199, 240),
                                borderRadius: BorderRadius.circular(10)),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: TextFormField(
                                  controller: controller
                                      .decorationPriceTextFieldList[index],
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText:
                                        'Enter Decoration ${index + 1} Price',
                                    border: InputBorder.none,
                                    hintStyle: GoogleFonts.josefinSans(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  style: GoogleFonts.josefinSans(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                            )),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          flex: 30,
                          child: Container(
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(8)),
                            height: 43,
                            child: TextButton(
                              onPressed: () async {
                                String image = await selectImage();
                                controller.addDecorationImage(image);
                              },
                              child: Text(
                                  controller.btnDecorationimageList[index],
                                  style: GoogleFonts.josefinSans(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ))
                    ],
                  )
                ],
              ));
        });
  });
}

//___________________________________PHOTOGRAPHY PORTION
photoGraphyPortion() {
  return GetBuilder<MakeOwnFormController>(builder: (controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
          height: 45,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 111, 199, 240),
              borderRadius: BorderRadius.circular(10)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: controller.PhotoCtrl,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Enter Per Photo Price',
                  border: InputBorder.none,
                  hintStyle: GoogleFonts.josefinSans(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
                style: GoogleFonts.josefinSans(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w800),
              ),
            ),
          )),
    );
  });
}

//___________________________________OUTDOOR PORTION
outdoorPortion() {
  return GetBuilder<MakeOwnFormController>(builder: (controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
          height: 45,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 111, 199, 240),
              borderRadius: BorderRadius.circular(10)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: controller.outdoorCtrl,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Enter Outdoor Service Charges',
                  border: InputBorder.none,
                  hintStyle: GoogleFonts.josefinSans(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
                style: GoogleFonts.josefinSans(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w800),
              ),
            ),
          )),
    );
  });
}

//________________________________________TITLE TEXT
Widget titleText = Text(
  "Add MakeOwn Package",
  style: GoogleFonts.roboto(
      fontSize: 18, color: Colors.white, fontWeight: FontWeight.w800),
);
