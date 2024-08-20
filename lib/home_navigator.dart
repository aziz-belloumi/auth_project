import 'package:convergeimmob/constants/app_colors.dart';
import 'package:convergeimmob/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeNavigatorScreen extends StatefulWidget {
  const HomeNavigatorScreen({super.key});

  @override
  State<HomeNavigatorScreen> createState() => _HomeNavigatorScreenState();
}

class _HomeNavigatorScreenState extends State<HomeNavigatorScreen> {
  int _currentIndex = 0;

  final PageController _pageController = PageController(initialPage: 0);

  final List<Widget> _pages = [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    print('Current Index: $_currentIndex');
    print('Pages List Length: ${_pages.length}');

    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages.isNotEmpty ? _pages : [Container()],
        onPageChanged: (index) {
          print('Page Changed: $index');
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: Container(
        height: size.height * 0.08,
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: GNav(
          rippleColor: Colors.black,
          hoverColor: Colors.black,
          gap: 8,
          activeColor: AppColors.white,
          backgroundColor: AppColors.gNavBgColor,
          iconSize: 24,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: const Duration(milliseconds: 400),
          tabBackgroundColor: AppColors.bluebgNavItem,
          color: AppColors.black,
          tabs: const [
            GButton(
              icon: Icons.home_outlined,
              text: 'Home',
            ),
            GButton(
              icon: Icons.message,
              text: 'Message',
            ),
            GButton(
              icon: Icons.favorite_border,
              text: 'Favorite',
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
            ),
          ],
          selectedIndex: _currentIndex,
          onTabChange: (index) {
            setState(() {
              _currentIndex = index;
              _pageController.jumpToPage(index);
            });
          },
        ),
      ),
    );
  }
}
/*import 'package:convergeimmob/constants/app_colors.dart';
import 'package:convergeimmob/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeNavigatorScreen extends StatefulWidget {
  const HomeNavigatorScreen({super.key});

  @override
  State<HomeNavigatorScreen> createState() => _HomeNavigatorScreenState();
}

class _HomeNavigatorScreenState extends State<HomeNavigatorScreen> {
  int _currentIndex = 0;

  final PageController _pageController = PageController(initialPage: 0);

  final List<Widget> _pages = [
    // LastminutesScreen(),
    // TransferScreen(),
    // HourlyScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
  ];

  // final NotificationController notificationController =
  // Get.put(NotificationController());

  // Future<void> _pullRefresh() async {
  //   notificationController.fetchReservation();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(

      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: Container(
        height: size.height * 0.08,
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: GNav(
          rippleColor: Colors.black,
          hoverColor: Colors.black,
          gap: 8,
          activeColor: AppColors.white,
          backgroundColor: AppColors.gNavBgColor,
          iconSize: 24,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: const Duration(milliseconds: 400),
          tabBackgroundColor: AppColors.bluebgNavItem,
          color: AppColors.black,
          tabs: const [
            GButton(
              icon: Icons.home_outlined,
              text: 'Home',
            ),
            GButton(
              icon: Icons.message,
              text: 'Message',
            ),
            GButton(
              icon: Icons.favorite_border,
              text: 'Favorite',
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
            ),
          ],
          selectedIndex: _currentIndex,
          onTabChange: (index) {
            setState(() {
              _currentIndex = index;
              _pageController.jumpToPage(index);
            });
          },
        ),
      ),
    );
  }
}
*/