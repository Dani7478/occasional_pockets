// ignore_for_file: must_be_immutable

import 'package:occasional_pockets/Controller/AdminControllers/admin_request_controller.dart';
import 'package:occasional_pockets/linked_screens.dart';

class AdminRequestDetailView extends StatefulWidget {
  AdminRequestDetailView({Key? key, required this.id, required this.role})
      : super(key: key);
  String id;
  String role;

  @override
  State<AdminRequestDetailView> createState() => _AdminRequestDetailViewState();
}

class _AdminRequestDetailViewState extends State<AdminRequestDetailView> {
  AdminRequestController controller = Get.put(AdminRequestController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  fetchData() async {
    await controller.fetchDetail(widget.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        shape: appBarDecoration,
        title: controller.singleList.isEmpty
            ? const Text('Pending...')
            : Text(
                controller.singleList[0]['package'].toString().toUpperCase(),
                style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w800),
              ),
      ),
      body: controller.singleList.isEmpty
          ? const Loader()
          : GetBuilder<AdminRequestController>(builder: (controller) {
              bool check = controller.ismakeown;
              String time = controller.singleList[0]['time'];
              String type = 'AM';
              int hour = int.parse(time.split(':').first);
              String minut = time.split(':')[1];

              if (hour > 12) {
                hour = hour - 12;
                type = 'PM';
              }
              if (minut == '0') {
                minut = '00';
              }

              String newTime = '$hour:$minut $type';

              return SingleChildScrollView(
                child: Column(
                  children: [
                    check == true ? divide() : const SizedBox(),
                    check == true
                        ? showData('PRICE',
                            controller.singleList[0]['price'].toString())
                        : const SizedBox(),
                    divide(),
                    showData('Name', controller.singleList[0]['name']),
                    divide(),
                    showData('Sender', controller.singleList[0]['senderEmail']),
                    divide(),
                    showData('Reciever', controller.singleList[0]['recieverEmail']),
                    divide(),
                    showData('Phone ', controller.singleList[0]['phone']),
                    divide(),
                    showData('Date ', controller.singleList[0]['date']),
                    divide(),
                    showData('Time ', newTime),
                    divide(),
                    showData(
                        'Status ',
                        controller.singleList[0]['status']
                            .toString()
                            .toUpperCase()),
                    divide(),
                    check == true
                        ? ItemDetail(controller: controller)
                        : const SizedBox(),
                    Accpeter(controller: controller, role: widget.role),
                  ],
                ),
              );
            }),
    );
  }

  divide() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Divider(
        color: Color.fromARGB(255, 53, 52, 52),
        indent: 5,
        // height: 0,
        thickness: 1,
      ),
    );
  }

  showData(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
              flex: 40,
              child: Text(
                title,
                style: GoogleFonts.roboto(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w800),
              )),
          Expanded(
              flex: 60,
              child: Text(
                value,
                style: GoogleFonts.roboto(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              )),
        ],
      ),
    );
  }
}

class Accpeter extends StatelessWidget {
  Accpeter({Key? key, required this.controller, required this.role})
      : super(key: key);

  AdminRequestController controller;
  String role;
  @override
  Widget build(BuildContext context) {
    return role == 'admin'
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: 55,
                    decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                      onPressed: () {
                        String id = controller.singleList[0].id;
                        controller.updateStatus(id, 'pending');
                      },
                      child: Text(
                        'Due Payment',
                        style: GoogleFonts.josefinSans(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: 55,
                    decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                      onPressed: () {
                        String id = controller.singleList[0].id;
                        controller.updateStatus(id, 'approved');
                      },
                      child: Text(
                        'Approve',
                        style: GoogleFonts.josefinSans(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: 55,
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                      onPressed: () {
                        String id = controller.singleList[0].id;
                        controller.updateStatus(id, 'reject');
                      },
                      child: Text(
                        'Reject',
                        style: GoogleFonts.josefinSans(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}

class ItemDetail extends StatelessWidget {
  ItemDetail({Key? key, required this.controller}) : super(key: key);
  AdminRequestController controller;
  @override
  Widget build(BuildContext context) {
    List foodLList = controller.singleList[0]['foodlist'] as List;
    List decorationList = controller.singleList[0]['decorationList'] as List;
    List djList = controller.singleList[0]['djList'] as List;

    return Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: foodLList.length,
            itemBuilder: (context, index) {
              return showData('Food', foodLList[index]);
            }),
        divide(),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: decorationList.length,
            itemBuilder: (context, index) {
              return showData('Decoration', decorationList[index]);
            }),
        divide(),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: djList.length,
            itemBuilder: (context, index) {
              return showData('DJ', djList[index]);
            }),
      ],
    );
  }

  divide() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Divider(
        color: Color.fromARGB(255, 53, 52, 52),
        indent: 5,
        // height: 0,
        thickness: 1,
      ),
    );
  }

  showData(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
              flex: 40,
              child: Text(
                title,
                style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w800),
              )),
          Expanded(
              flex: 60,
              child: Text(
                value,
                style: GoogleFonts.roboto(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              )),
        ],
      ),
    );
  }
}
