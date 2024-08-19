import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_meal/screens/on_board/onboard_screen.dart';
import 'package:smart_meal/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: CustomColors.greyColor.withOpacity(.2),
          primary: CustomColors.yellowSecondaryLight,
          secondary: CustomColors.yellowSecondaryLight,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          tertiary: CustomColors.greyColor.withOpacity(.4),
        ),
        useMaterial3: true,
        fontFamily: GoogleFonts.poppins().fontFamily,
        scaffoldBackgroundColor: CustomColors.blackprimaryDark,
        appBarTheme: AppBarTheme(
          backgroundColor: CustomColors.blackprimaryDark,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        // other dark theme properties...
      ),
      themeMode: ThemeMode.dark,
      home: const OnBoardingScreen(),
    );
  }
}
