import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hungry/views/screens/auth/welcome_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const Color backgroundColor = Colors.white; // Replace with your desired background colors.dart

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      startTime();
    });
  }

  startTime() async {
    return Timer(
       Duration(milliseconds: 1500),
          () {
        // Replace 'LoginScreen' with your actual login screen
            Get.offAll(() =>  WelcomePage());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/images/kitchen.svg', // Replace with your actual logo path
              height: 200,
            ),
            SizedBox(height: 50),
            Text(
              'Hungry',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

// Placeholder for LoginScreen, replace it with your actual LoginScreen class
class PlaceholderLoginScreen extends StatelessWidget {
  const PlaceholderLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('welcome page'),
      ),
      body: Center(
        child: Text('hungry'),
      ),
    );
  }
}
