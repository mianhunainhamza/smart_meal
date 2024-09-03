import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smart_meal/providers/cart_provider.dart';
import 'package:smart_meal/screens/on_board/onboard_screen.dart';
import 'package:smart_meal/utils/colors.dart';
import 'providers/inventory_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InventoryProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
        child: const MyApp(),
    ),
  );
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
          primary: Colors.green,
          secondary: Colors.green,
          onPrimary: Colors.black,
          surface: Colors.white.withOpacity(.9),
          onSecondary: Colors.white,
          tertiary: CustomColors.blackprimaryDark.withOpacity(.6),
        ),
        useMaterial3: true,
        fontFamily: GoogleFonts.poppins().fontFamily,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      themeMode: ThemeMode.dark,
      home: const OnBoardingScreen(),
    );
  }
}
