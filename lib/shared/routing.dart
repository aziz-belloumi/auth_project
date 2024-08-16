import 'package:convergeimmob/views/welcome_view_one.dart';
import 'package:convergeimmob/views/welcome_view_three.dart';
import 'package:convergeimmob/views/welcome_view_two.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Import for using Material widgets
import 'package:get/get.dart';

class RoutingScreen extends StatefulWidget {
  const RoutingScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _RoutingScreenState createState() => _RoutingScreenState();
}

class _RoutingScreenState extends State<RoutingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemBackground,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: const [
              WelcomeViewOne(),
              WelcomeViewTwo(),
              WelcomeViewThree(),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: _currentPage == index ? 32 : 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? Color(0xFF3742FA)
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      if (_currentPage == 2) {
                        Get.offNamed('/login');
                      } else {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    label: Text(
                      "Next",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Color(0xFF3742FA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8.0), // Adjust the radius as needed
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
