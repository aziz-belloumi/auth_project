import 'package:convergeimmob/favorite_view.dart';
import 'package:convergeimmob/home_screen.dart';
import 'package:convergeimmob/message_view.dart';
import 'package:convergeimmob/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:navbar_router/navbar_router.dart';

class HomeNavigatorScreen extends StatefulWidget {
  const HomeNavigatorScreen({super.key});

  @override
  State<HomeNavigatorScreen> createState() => _HomeNavigatorScreenState();
}

class _HomeNavigatorScreenState extends State<HomeNavigatorScreen> {

  List<NavbarItem> items = [
    const NavbarItem(Icons.home_outlined, 'Home',
        backgroundColor: mediumPurple,
        selectedIcon: Icon(
          Icons.home,
          size: 26,
        )),
    const NavbarItem(Icons.favorite, 'Favorite',
        backgroundColor: mediumPurple,
        selectedIcon: Icon(
          Icons.favorite,
          size: 26,
        )),
    const NavbarItem(Icons.message, 'message',
        backgroundColor: mediumPurple,
        selectedIcon: Icon(
          Icons.message,
          size: 26,
        )),
  ];

  final Map<int, Map<String, Widget>> _routes = {
    0: {
      '/home_screen': HomeScreen(),
    },
    1: {
      '/favorite': const FavoriteView(),
    },
    2: {
      '/message': const MessageView(),
    },
  };
  @override
  Widget build(BuildContext context) {
    return NavbarRouter(
      errorBuilder: (context) {
        return const HomeNavigatorScreen();
      },
      onBackButtonPressed: (isExiting) {
        return isExiting;
      },
      destinationAnimationCurve: Curves.fastOutSlowIn,
      destinationAnimationDuration: 600,
      decoration:
      NavbarDecoration(navbarType: BottomNavigationBarType.shifting),
      destinations: [
        for (int i = 0; i < items.length; i++)
          DestinationRouter(
            navbarItem: items[i],
            destinations: [
              for (int j = 0; j < _routes[i]!.keys.length; j++)
                Destination(
                  route: _routes[i]!.keys.elementAt(j),
                  widget: _routes[i]!.values.elementAt(j),
                ),
            ],
            initialRoute: _routes[i]!.keys.first,
          ),
      ],
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