import 'dart:convert';
import 'package:occasional_pockets/View/Common%20Widgets/view_image.dart';
import 'package:occasional_pockets/linked_screens.dart';

serviceCard(String productImage, String productName) {
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
          leading: InkWell(
            onTap: () {
              Get.to(ImageView(image: productImage));
            },
            child: Container(
              child: Image.memory(
                base64.decode(productImage.toString()),
                fit: BoxFit.fill,
              ),
            ),
          ),
          title: Text(
            productName,
            style: GoogleFonts.josefinSans(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.w800),
          ),
        ),
      ),
    ),
  );
}
