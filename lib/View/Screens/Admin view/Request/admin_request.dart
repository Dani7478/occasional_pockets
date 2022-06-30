import 'package:occasional_pockets/Controller/AdminControllers/admin_request_controller.dart';
import 'package:occasional_pockets/linked_screens.dart';

class AdminRequest extends StatelessWidget {
  const AdminRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AdminRequestController adminReqCtrl = Get.put(AdminRequestController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: titleText,
        shape: appBarDecoration,
      ),
      body: const MainView(),
    );
  }
}

Widget titleText = Text(
  "Request",
  style: GoogleFonts.roboto(
      fontSize: 18, color: Colors.white, fontWeight: FontWeight.w800),
);

//_____________________________MAIN VIEW
class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminRequestController>(builder: (controller) {
      return ListView.builder(
          itemCount: controller.list[0].length,
          itemBuilder: (context, index) {
            String username = controller.list[0][index];
            String pkg = controller.list[1][index];
            String status = controller.list[2][index];
            String phone = controller.list[3][index];
            Color color;
            if (status == 'pending') {
              color = Colors.yellowAccent;
            } else if (status == 'reject') {
              color = Colors.red;
            } else if (status == 'approved') {
              color = Colors.green;
            } else {
              color = Colors.white;
            }
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Container(
                height: 120,
                decoration: const BoxDecoration(
                    color: Color(0xfff95b3f0),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )),
                child: Center(
                    child: ListTile(
                  leading: Container(
                    height: 55,
                    width: 100,
                    decoration: BoxDecoration(
                        //color: primaryColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text(
                        pkg,
                        style: GoogleFonts.josefinSans(
                            fontSize: 14,
                            color: const Color.fromARGB(255, 248, 2, 2),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  title: Text(
                    username,
                    style: GoogleFonts.josefinSans(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    phone,
                    style: GoogleFonts.josefinSans(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: Container(
                    height: 45,
                    width: 80,
                    decoration: BoxDecoration(
                        color: color, borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text(
                        status,
                        style: GoogleFonts.josefinSans(
                            fontSize: 14,
                            color: const Color.fromARGB(255, 22, 21, 21),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )),
              ),
            );
          });
    });
  }
}
