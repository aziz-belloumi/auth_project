import 'package:convergeimmob/shared/routing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _startTextAnimation = false;

  @override
  void initState() {
    super.initState();
    // Simulate a delay before showing the text animation
    Timer(Duration(milliseconds: 2600), () {
      setState(() {
        _startTextAnimation = true;
      });
      Timer(Duration(milliseconds: 3000), () {
        Get.offAll(() => RoutingScreen(),
            transition: Transition.fade,
            duration: Duration(milliseconds: 1200));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color(0xFF3742FA), // Background color for the splash screen
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo with rotating animation
            TweenAnimationBuilder(
              tween: Tween<double>(
                  begin: 0, end: -(2 * 3.14)), // Rotate 360 degrees
              duration: Duration(milliseconds: 2000),
              builder: (context, value, child) {
                // Scale value based on rotation angle
                double scale =
                    value / (2 * 3.14); // Adjust the scaling factor as needed
                return Transform(
                  transform: Matrix4.identity()
                    ..rotateY(value) // Rotate horizontally
                    ..scale(scale), // Scale transformation
                  alignment: Alignment.center,
                  child: child!,
                );
              },
              child: Transform(
                transform: Matrix4.rotationZ(math.pi),
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/icons/app_logo.png', // Your app logo
                  //height: MediaQuery.of(context).size.width * 0.3, // Initial size based on screen width
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
              child: Visibility(
                visible: _startTextAnimation,
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 1300),
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: child,
                    );
                  },
                  child: Text(
                    'Convergimmob',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.09,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
