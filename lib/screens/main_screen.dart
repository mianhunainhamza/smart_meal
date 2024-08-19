import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../constants.dart';
import 'home_screen/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTab = 0;
  List<Widget> screens = const [
    HomeScreen(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
        onTap: (index) {
          setState(() {
            currentTab = index;
          });
        },
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onPrimary,
        items: [
          BottomNavigationBarItem(
            backgroundColor:Theme.of(context).colorScheme.onSecondary,
        icon: const Icon(Iconsax.home),
            label: "Home",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Iconsax.heart),
            label: "Favorites",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Iconsax.calendar_2),
            label: "Meal Plan",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Iconsax.setting),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
