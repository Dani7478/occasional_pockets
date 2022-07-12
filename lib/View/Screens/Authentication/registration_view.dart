// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:occasional_pockets/Controller/registration_controller.dart';
import 'package:occasional_pockets/View/Common%20Functions/app_color.dart';
import 'package:occasional_pockets/View/Screens/Authentication/login_view.dart';
import 'package:occasional_pockets/linked_screens.dart';

RegistrationController registerCrl = Get.put(RegistrationController());

class RegistrationView extends StatelessWidget {
  const RegistrationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            //color: Color.fromARGB(255, 22, 22, 22),
            image: DecorationImage(
                image: AssetImage('images/background.png'),
                fit: BoxFit.fill,
                alignment: Alignment.bottomCenter),
          ),
          child: Column(
            children: const [
              TopTextSection(),
              BottomPortion(),
            ],
          ),
        ),
      ),
    );
  }
}

//_____________________________________TOP LOGIN TEXT SECTION

class TopTextSection extends StatelessWidget {
  const TopTextSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Align(
        alignment: Alignment.center,
        child: Text('Registration View',
            style: GoogleFonts.josefinSans(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.w500)),
      ),
    );
  }
}

//full name
//email
//contact no
//city
//role
//______________________________________MIDDLE TEXTFIELD SECTION SECTION
class BottomPortion extends StatelessWidget {
  const BottomPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              nameTextField(),
              SizedBox(height: size.height * 0.02),
              emailTextFormField(),
              SizedBox(height: size.height * 0.02),
              phoneTextFormField(),
              SizedBox(height: size.height * 0.02),
              cityTextFormField(),
              SizedBox(height: size.height * 0.02),
              passwordTextFormField(),
              SizedBox(height: size.height * 0.02),
              rolePortion(),
              SizedBox(height: size.height * 0.05),
              loginButton(),
              SizedBox(height: size.height * 0.03),
              registrationText(),
            ],
          ),
        ));
  }

  //____________________________TEXTFORMFIELD FOR NAME
  nameTextField() {
    return TextFormField(
      controller: registerCrl.nameController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: 'Full Name',
        labelStyle: GoogleFonts.josefinSans(
          color: Colors.white,
        ),
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.person, color: Colors.white),
      ),
      style: GoogleFonts.josefinSans(
        color: Colors.white,
      ),
    );
  }

  //____________________________TEXTFORMFIELD FOR EMAIL
  emailTextFormField() {
    return TextFormField(
      controller: registerCrl.emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email Address',
        border: OutlineInputBorder(),
        labelStyle: GoogleFonts.josefinSans(
          color: Colors.white,
        ),
        prefixIcon: Icon(Icons.email, color: Colors.white),
      ),
      style: GoogleFonts.josefinSans(
        color: Colors.white,
      ),
    );
  }

  //____________________________TEXTFORMFIELD FOR PHONE
  phoneTextFormField() {
    return TextFormField(
      controller: registerCrl.contactController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'Contact No',
        border: OutlineInputBorder(),
        labelStyle: GoogleFonts.josefinSans(
          color: Colors.white,
        ),
        prefixIcon: Icon(Icons.call, color: Colors.white),
      ),
      style: GoogleFonts.josefinSans(
        color: Colors.white,
      ),
    );
  }

  //____________________________TEXTFORMFIELD FOR CITY
  cityTextFormField() {
    return TextFormField(
      controller: registerCrl.cityController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'City',
        border: OutlineInputBorder(),
        labelStyle: GoogleFonts.josefinSans(
          color: Colors.white,
        ),
        prefixIcon: Icon(Icons.location_city, color: Colors.white),
      ),
      style: GoogleFonts.josefinSans(
        color: Colors.white,
      ),
    );
  }

  //____________________________TEXTFORMFIELD FOR PASSWORD
  passwordTextFormField() {
    return TextFormField(
      controller: registerCrl.passwController,
      keyboardType: TextInputType.phone,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: GoogleFonts.josefinSans(
          color: Colors.white,
        ),
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.lock, color: Colors.white),
        suffixIcon: Icon(Icons.remove_red_eye, color: Colors.white),
      ),
      style: GoogleFonts.josefinSans(
        color: Colors.white,
      ),
    );
  }

  //______________________________REGISTERATION BUTTON
  loginButton() {
    return GetBuilder<RegistrationController>(builder: (controller) {
      return InkWell(
        onTap: () {
          controller.postData();
        },
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              color: primaryColor, borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Text('Register',
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
        Text('I have Already Account',
            style: GoogleFonts.roboto(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w200)),
        InkWell(
          onTap: () {
            navigatorScreen(const LoginView());
          },
          child: Text(' Login',
              style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: primaryColor,
                  fontWeight: FontWeight.w400)),
        ),
      ],
    );
  }

  //______________________________________RADIO BUTTON ROW
  rolePortion() {
    return GetBuilder<RegistrationController>(builder: (controller) {
      return Row(
        children: [
          Expanded(
            flex: 40,
            child: Text('Select Role',
                style: GoogleFonts.josefinSans(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500)),
          ),
          Expanded(
            flex: 30,
            child: Row(children: [
              Radio(
                  activeColor: primaryColor,
                  value: 'user',
                  groupValue: registerCrl.role,
                  onChanged: (value) {
                    controller.updateRole(value.toString());
                  }),
              const SizedBox(
                width: 3,
              ),
              Text('User',
                  style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w400))
            ]),
          ),
          Expanded(
            flex: 30,
            child: Row(children: [
              Radio(
                  activeColor: primaryColor,
                  value: 'admin',
                  groupValue: registerCrl.role,
                  onChanged: (value) {
                    controller.updateRole(value.toString());
                  }),
              const SizedBox(
                width: 5,
              ),
              Text('Admin',
                  style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w400))
            ]),
          ),
        ],
      );
    });
  }
}
