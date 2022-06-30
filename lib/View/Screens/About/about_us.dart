// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:occasional_pockets/linked_screens.dart';
import '../Authentication/login_view.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AboutUsController abouCtrl = Get.put(AboutUsController());
    Size size = MediaQuery.of(context).size;
    String userName = 'Your Name';
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const TopImageSection(),
          mySpace(size.height * 0.03),
          NameSection(name: userName),
          const Expanded(child: BottomSettingSection()),
        ],
      )),
    );
  }

  mySpace(double siz) {
    return SizedBox(
      height: siz,
    );
  }
}

//_____________________________________________TOP IMAGE SECTION

class TopImageSection extends StatelessWidget {
  const TopImageSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<AboutUsController>(builder: (controller) {
      return SizedBox(
          width: size.width,
          height: 250,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            child: controller.image == null
                ? Center(
                    child: Text('Pending..',
                        style: GoogleFonts.josefinSans(
                            color: primaryColor, fontSize: 24)))
                : Image.memory(
                    base64.decode(controller.image.toString()),
                    fit: BoxFit.fill,
                  ),
          ));
    });
  }
}

//____________________________________________NAME SECTION

class NameSection extends StatelessWidget {
  NameSection({Key? key, required this.name}) : super(key: key);

  String name;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name,
          style: GoogleFonts.josefinSans(
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        InkWell(
          onTap: () {},
          child: Text(
            'Edit Photo',
            style: GoogleFonts.josefinSans(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: Colors.grey,
            ),
          ),
        )
      ],
    );
  }
}

//__________________________________________________BOTTOM SETTING SECTION

class BottomSettingSection extends StatelessWidget {
  const BottomSettingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AboutUsController controller = Get.put(AboutUsController());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        children: [
          //dark mood
          InkWell(
            onTap: () {},
            child: forDarkMood(
                Icons.dark_mode, 'Dark Mood', controller.isDark, controller),
          ),
          //privacy
          InkWell(
            onTap: () {},
            child: settingCard(Icons.lock, 'Privacy'),
          ),

          //Share
          InkWell(
            onTap: () {},
            child: settingCard(Icons.share, 'Share'),
          ),
          const Divider(
            color: Color.fromARGB(255, 223, 219, 219),
            indent: 5,
            height: 0,
            thickness: 0.5,
          ),
          //Notification
          InkWell(
            onTap: () {},
            child: settingCard(Icons.notifications, 'Notification'),
          ),

          //FeedBack
          InkWell(
            onTap: () {},
            child: settingCard(Icons.feedback, 'Feedback'),
          ),

          //Help
          InkWell(
            onTap: () {},
            child: settingCard(Icons.help_outline, 'Help'),
          ),

          const Divider(
            color: Color.fromARGB(255, 223, 219, 219),
            indent: 5,
            height: 0,
            thickness: 0.5,
          ),

          //Term Service
          InkWell(
            onTap: () {},
            child: settingCard(Icons.rule, 'Term & Condition'),
          ),

          //Privacy Plicy
          InkWell(
            onTap: () {},
            child: settingCard(Icons.policy, 'Term & Condition'),
          ),

          const Divider(
            color: Color.fromARGB(255, 223, 219, 219),
            indent: 5,
            height: 0,
            thickness: 0.5,
          ),
          //Logout
          InkWell(
            onTap: () async {
              final pref = await SharedPreferences.getInstance();
              pref.setString('role', 'null');
              navigatorScreen(const LoginView());
            },
            child: settingCard(Icons.logout, 'Logout'),
          ),
        ],
      ),
    );
  }

//__________SETTING CARD
  settingCard(IconData icon, String settingName) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.black,
        size: 20,
      ),
      title: Text(settingName),
    );
  }

  //__________SETTING CARD
  forDarkMood(IconData icon, String settingName, bool isDark,
      AboutUsController controller) {
    return GetBuilder<AboutUsController>(builder: (cont1) {
      return ListTile(
        leading: Icon(
          icon,
          color: Colors.black,
          size: 20,
        ),
        title: Text(settingName),
        trailing: Switch(
            activeColor: Colors.red,
            value: cont1.isDark,
            onChanged: (value) {
              controller.updateDarkMood(value);
              Get.changeTheme(
                Get.isDarkMode ? ThemeData.light() : ThemeData.dark(),
              );
            }),
      );
    });
  }
}
