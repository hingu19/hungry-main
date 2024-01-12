import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hungry/controller/authController.dart';
import 'package:hungry/views/screens/page_switcher.dart';
import 'package:hungry/views/utils/AppColor.dart';
import 'package:hungry/views/widgets/custom_text_field.dart';
import 'package:hungry/views/widgets/modals/login_modal.dart';

import '../../../util/colors.dart';
import '../../../util/common_methods.dart';
import '../../utils/shadow_container_widget.dart';

class RegisterModal extends StatefulWidget {
  @override
  RegisterModalState createState() => RegisterModalState();

}

class RegisterModalState extends State<RegisterModal> {
  // TextEditingController emailController = TextEditingController();
  // TextEditingController fullNameController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  // TextEditingController retypePasswordController = TextEditingController();

  // bool isEmailValid = true;
  // bool isPasswordValid = true;
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

  var controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 85 / 100,
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            physics: BouncingScrollPhysics(),
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width * 35 / 100,
                  margin: EdgeInsets.only(bottom: 20),
                  height: 6,
                  decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
                ),
              ),
              // header
              Container(
                margin: EdgeInsets.only(bottom: 24),
                child: Text(
                  'Get Started',
                  style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w700, fontFamily: 'inter'),
                ),
              ),
              // Form
              CustomTextField(
                title: 'Email',
                hint: 'youremail@email.com',
                controller: controller.emailController,
                onChanged: (value) {
                  // Handle the onChanged event, e.g., update the emailController
                  // emailController.text = value;
                },
              ),

              // CustomTextField(
              //   title: 'Full Name',
              //   hint: 'Your Full Name',
              //   controller: fullNameController,
              //   margin: EdgeInsets.only(top: 16), onChanged: (email) {  },
              // ),
              CustomTextField(
                title: 'Password',
                hint: '**********',
                obsecureText: true,
                controller: controller.passwordController,
                // onChanged: (password) => validatePassword(password),
                // errorText: isPasswordValid ? null : 'Password must be at least 6 characters',
                margin: EdgeInsets.only(top: 16), onChanged: (email) {  },
              ),

              CustomTextField(
                title: 'Retype Password',
                hint: '**********',
                obsecureText: true,
                controller: controller.confirmPasswordController,
                margin: EdgeInsets.only(top: 16), onChanged: (email) {  },
              ),
              // Login textbutton
              Container(
                margin: EdgeInsets.only(top: 32, bottom: 6),
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    // if (isEmailValid && isPasswordValid) {
                    //
                    //   // Perform registration logic
                    //   Navigator.of(context).pop();
                    //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PageSwitcher()));
                    // } else {
                    //   // Show an error message or disable the register button
                    // }
                    if (controller.emailController.text.isEmpty) {
                      CommonMethod()
                          .getXSnackBar('Error', 'Please enter email', red);
                    } else if (!emailRegex
                        .hasMatch(controller.emailController.text)) {
                      CommonMethod().getXSnackBar(
                          'Error', 'Please enter valid email', red);
                    } else if (controller.passwordController.text.isEmpty) {
                      CommonMethod().getXSnackBar(
                          'Error', 'Please enter password', red);
                    } else if (controller
                        .confirmPasswordController.text.isEmpty) {
                      CommonMethod().getXSnackBar(
                          'Error', 'Please enter confirm password', red);
                    } else if (controller.passwordController.text !=
                        controller.confirmPasswordController.text) {
                      CommonMethod().getXSnackBar(
                          'Error', 'Passwords do not match!', red);
                    } else {
                      controller.registerWithEmailAndPassword(context);
                    }
                  },

                  child: Text('Register', style: TextStyle(color: AppColor.secondary, fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'inter')),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    primary: AppColor.primarySoft,
                  ),
                ),
              ),

           // Register Button
              GestureDetector(
                onTap: () async {
                  User? user = await controller.handleSignInGoogle();
                  if (user != null) {
                    // Successfully signed in with Google
                    // Perform further actions as needed
                  }
                },
                child: ShadowContainerWidget(
                    padding: 0,
                    widget: SizedBox(
                      height: 50,
                      child: Row(
                        // mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Text('Sign Up with Google'),
                          // Add more widgets if needed
                        ],
                      ),
                    )),
              ),

              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                    isScrollControlled: true,
                    builder: (context) {
                      return LoginModal();
                    },
                  );
                },
                style: TextButton.styleFrom(
                  primary: Colors.white,
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'Have an account? ',
                    style: TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                          style: TextStyle(
                            color: AppColor.primary,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'inter',
                          ),
                          text: 'Log in')
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }


  // void validateEmail(String email) {
  //   // Use a regular expression for basic email validation
  //   RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  //   setState(() {
  //     isEmailValid = emailRegex.hasMatch(email);
  //   });
  // }
  //
  // void validatePassword(String password) {
  //   // Password must be at least 6 characters
  //   setState(() {
  //     isPasswordValid = password.length >= 6;
  //   });
  // }
}
