// ignore_for_file: must_be_immutable

import 'package:occasional_pockets/Controller/AdminControllers/admin_feedback_controller.dart';
import 'package:occasional_pockets/linked_screens.dart';

class AdminFeedbackView extends StatelessWidget {
  AdminFeedbackView({Key? key, required this.role}) : super(key: key);
  String role;

  @override
  Widget build(BuildContext context) {
    AdminFeedbackController ctrl = Get.put(AdminFeedbackController());
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          shape: appBarDecoration,
          title: Text(
            'Marquee Feedback',
            style: GoogleFonts.roboto(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.w800),
          ),
        ),
        body: GetBuilder<AdminFeedbackController>(builder: (controller) {
          return controller.loading == true
              ? Loader()
              : ListView.builder(
                  itemCount: role == 'admin'
                      ? controller.adminFeedbackList.length
                      : controller.userFeedbackList.length,
                  itemBuilder: (context, index) {
                    String name = 'pending';
                    String message = 'pending';
                    String email = 'pending';
                    int rate = 0;
                    if (role == 'admin') {
                      name = controller.adminFeedbackList[index]['name'];
                      message = controller.adminFeedbackList[index]['feedback'];
                      name = controller.adminFeedbackList[index]['senderEmail'];
                      rate = controller.adminFeedbackList[index]['rate'];
                    }
                    if (role == 'user') {
                      name = controller.userFeedbackList[index]['marqueeName'];
                      message = controller.userFeedbackList[index]['feedback'];
                      email =
                          controller.userFeedbackList[index]['recieverEmail'];
                      rate = controller.userFeedbackList[index]['rate'];
                    }

                    return FeedbackCard(
                        name: name, email: email, message: message, rate: rate);
                  });
        }));
  }
}

class FeedbackCard extends StatelessWidget {
  FeedbackCard({
    Key? key,
    required this.name,
    required this.email,
    required this.message,
    required this.rate,
  }) : super(key: key);

  String name;
  String email;
  String message;
  int rate;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Container(
        height: 120,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Card(
          color: Colors.blueGrey,
          elevation: 15,
          child: Center(
            child: ListTile(
              leading: const Icon(Icons.person, size: 30, color: Colors.white),
              title: Text(
                name,
                style: GoogleFonts.josefinSlab(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w800),
              ),
              subtitle: Text(
                message,
                style: GoogleFonts.josefinSlab(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              trailing: Text(
                '$rate',
                style: GoogleFonts.josefinSlab(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
