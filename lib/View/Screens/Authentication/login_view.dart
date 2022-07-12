import 'package:occasional_pockets/Controller/login_controller.dart';
import 'package:occasional_pockets/View/Screens/Authentication/registration_view.dart';
import 'package:occasional_pockets/linked_screens.dart';

LoginController loginCrl = Get.put(LoginController());

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            decoration: const BoxDecoration(
              //color: Color.fromARGB(255, 22, 22, 22),
              image: DecorationImage(
                  image: AssetImage('images/background.png'),
                  fit: BoxFit.fill,
                  alignment: Alignment.bottomCenter),
            ),
            child: Column(
              children: const [
                TopSection(),
                MiddleSection(),
              ],
            ),
          )),
    );
  }
}

//_____________________________________TOP LOGIN TEXT SECTION

class TopSection extends StatelessWidget {
  const TopSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Align(
        child: Text('Login View',
            style: GoogleFonts.josefinSans(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.w500)),
      ),
    );
  }
}

//______________________________________MIDDLE TEXTFIELD SECTION SECTION
class MiddleSection extends StatelessWidget {
  const MiddleSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      flex: 5,
      child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                emailTextFormField(),
                SizedBox(height: size.height * 0.02),
                passwordTextFormField(),
                SizedBox(height: size.height * 0.05),
                loginButton(),
                SizedBox(height: size.height * 0.03),
                registrationText(),
              ],
            ),
          )),
    );
  }

  //____________________________TEXTFORMFIELD FOR EMAIL
  emailTextFormField() {
    return TextFormField(
      controller: loginCrl.emailController,
      keyboardType: TextInputType.visiblePassword,
      // obscureText: true,
      decoration: InputDecoration(
        labelText: 'Email Address',
        labelStyle: GoogleFonts.josefinSans(
          color: Colors.white,
        ),
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.email, color: Colors.white),
        //suffixIcon: Icon(Icons.remove_red_eye),
      ),
      style: GoogleFonts.josefinSans(
        color: Colors.white,
      ),
    );
  }

  //____________________________TEXTFORMFIELD FOR PASSWORD
  passwordTextFormField() {
    return TextFormField(
      controller: loginCrl.passwController,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(),
        labelStyle: GoogleFonts.josefinSans(
          color: Colors.white,
        ),
        prefixIcon: const Icon(Icons.lock, color: Colors.white),
        suffixIcon: const Icon(Icons.remove_red_eye, color: Colors.white),
      ),
      style: GoogleFonts.josefinSans(
        color: Colors.white,
      ),
    );
  }

  //______________________________LOGIN BUTTON
  loginButton() {
    return GetBuilder<LoginController>(builder: (controller) {
      return InkWell(
        onTap: () {
          controller.checkUser();
        },
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              color: primaryColor, borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Text('Login',
                style: GoogleFonts.josefinSans(
                    fontSize: 28,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500)),
          ),
        ),
      );
    });
  }

  //____________________________REGISTRATION TEXT
  registrationText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('I have no any account',
            style: GoogleFonts.roboto(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w200)),
        InkWell(
          onTap: () {
            navigatorScreen(const RegistrationView());
          },
          child: Text(' Register Account',
              style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: primaryColor,
                  fontWeight: FontWeight.w400)),
        ),
      ],
    );
  }
}
