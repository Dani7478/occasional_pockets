import 'package:occasional_pockets/linked_screens.dart';

snackBar(
  String title,
  String subtitle,
  IconData icon,
) {
  Get.snackbar(title, subtitle,
      titleText: Text(
        title,
        style: GoogleFonts.josefinSans(
            fontSize: 14, color: Colors.white, fontWeight: FontWeight.w800),
      ),
      messageText: Text(
        subtitle,
        style: GoogleFonts.josefinSans(
            fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600),
      ),
      backgroundColor: Colors.grey,
      animationDuration: const Duration(seconds: 1),
      duration: const Duration(seconds: 2),
      icon: Icon(icon, color: Colors.white),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10));
}
