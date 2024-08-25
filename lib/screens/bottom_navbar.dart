import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:smart_meal/screens/shopping/shopping_page.dart';
import 'home_screen/home_screen.dart'; // Ensure this import is correct

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int currentIndex = 0;
  final List<Widget> screens = const [
    HomeScreen(),
    ShoppingPage(),
    Scaffold(),
    Scaffold(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: GNav(
        rippleColor: Theme.of(context).colorScheme.primary,
        activeColor: Theme.of(context).colorScheme.primary,
        iconSize: 25,
        padding: const EdgeInsets.only(left: 30, right: 30,bottom: 15,top: 5),
        duration: const Duration(milliseconds: 300),
        tabBackgroundColor: Theme.of(context).colorScheme.onSecondary,
        color: Theme.of(context).colorScheme.onPrimary,
        tabs: const [
          GButton(
            icon: Icons.home,
          ),
          GButton(
            icon: Icons.shopping_cart,
          ),
          GButton(
            icon: Icons.calendar_today,
          ),
          GButton(
            icon: Icons.settings,
          ),
        ],
        selectedIndex: currentIndex,
        onTabChange: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
