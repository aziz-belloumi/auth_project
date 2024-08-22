import 'package:convergeimmob/constants/app_colors.dart';
import 'package:convergeimmob/favorite_view.dart';
import 'package:convergeimmob/message_view.dart';
import 'package:flutter/material.dart';
import 'package:convergeimmob/home_screen.dart';

class HomeNavigatorScreen extends StatefulWidget {
  const HomeNavigatorScreen({super.key});

  @override
  State<HomeNavigatorScreen> createState() => _HomeNavigatorScreenState();
}

class _HomeNavigatorScreenState extends State<HomeNavigatorScreen> {
  int _currentIndex = 0;
  bool _isNavBarVisible = true;

  final PageController _pageController = PageController(initialPage: 0);
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeScreen(onDrawerChanged: (isOpen) => _onDrawerChanged(isOpen)),
      const MessageView(),
      const FavoriteView(),
    ];
  }
  void _onDrawerChanged(bool isOpen) {
    if (isOpen) {
      setState(() {
        _isNavBarVisible = false;
      });
    } else {
      // Introduce a delay before making the BottomNavigationBar reappear
      Future.delayed(const Duration(milliseconds: 200), () {
        if(mounted) {
          setState(() {
            _isNavBarVisible = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size ;
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const AlwaysScrollableScrollPhysics(),
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: _isNavBarVisible
          ? BottomNavigationBar(
        selectedItemColor: AppColors.bluebgNavItem,
        unselectedItemColor: AppColors.black,
        unselectedLabelStyle: TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.w500,
          fontSize: size.height * 0.017,
        ),
        selectedLabelStyle: TextStyle(
          color: AppColors.bluebgNavItem,
          fontWeight: FontWeight.w500,
          fontSize: size.height * 0.017,
        ),
        backgroundColor: AppColors.gNavBgColor,
        currentIndex: _currentIndex,
        onTap: (index) {
          _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut
          );
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: size.height * 0.035,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message_outlined,
              size: size.height * 0.035,
            ),
            label: 'message',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              size: size.height * 0.035,
            ),
            label: 'favorite',
          ),
        ],
      )
          : const SizedBox.shrink(), // Hide the BottomNavigationBar when not visible
    );
  }
}




// import 'package:convergeimmob/constants/app_colors.dart';
// import 'package:convergeimmob/home_screen.dart';
// import 'package:convergeimmob/views/profile_view.dart';
// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
//
// class HomeNavigatorScreen extends StatefulWidget {
//   const HomeNavigatorScreen({super.key});
//
//   @override
//   State<HomeNavigatorScreen> createState() => _HomeNavigatorScreenState();
// }
//
// class _HomeNavigatorScreenState extends State<HomeNavigatorScreen> {
//   int _currentIndex = 0;
//
//   final PageController _pageController = PageController(initialPage: 0);
//
//   final List<Widget> _pages = [
//     HomeScreen(),
//     HomeScreen(),
//     HomeScreen(),
//     ProfileView(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//
//     return Scaffold(
//       body: PageView(
//         controller: _pageController,
//         physics: const AlwaysScrollableScrollPhysics(),
//         children: _pages.isNotEmpty ? _pages : [Container()],
//         onPageChanged: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//       ),
//       bottomNavigationBar: Container(
//         height: size.height * 0.08,
//         padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//         child: GNav(
//           rippleColor: Colors.black,
//           hoverColor: Colors.black,
//           gap: 8,
//           activeColor: AppColors.white,
//           backgroundColor: AppColors.gNavBgColor,
//           iconSize: 24,
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//           duration: const Duration(milliseconds: 200),
//           tabBackgroundColor: AppColors.bluebgNavItem,
//           color: AppColors.black,
//           tabs: const [
//             GButton(
//               icon: Icons.home_outlined,
//               text: 'Home',
//             ),
//             GButton(
//               icon: Icons.message,
//               text: 'Message',
//             ),
//             GButton(
//               icon: Icons.favorite_border,
//               text: 'Favorite',
//             ),
//             GButton(
//               icon: Icons.person,
//               text: 'Profile',
//             ),
//           ],
//           selectedIndex: _currentIndex,
//           onTabChange: (index) {
//             setState(() {
//               _currentIndex = index;
//               _pageController.jumpToPage(index);
//             });
//           },
//         ),
//       ),
//     );
//   }
// }