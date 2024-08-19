import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontSizes {


  static const double mainHeadingFontSize = 24;
  static const double subtitleFontSize = 15;
  static const double sectionTitleFontSize = 20;
  static const double vocabularyCardWidth = 150;
  static const double vocabularyCardHeight = 150;
  static const double tutorCardWidth = 100;
  static const double tutorCardHeight = 100;


  static TextStyle mainHeading = GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: mainHeadingFontSize,
    color: Colors.black,
  );

  static TextStyle mainHeadingRoom = GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: 25,
    color: Colors.grey,
  );

  static TextStyle mainHeadingNormal = GoogleFonts.actor(
    fontWeight: FontWeight.w600,
    fontSize: mainHeadingFontSize,
    color: Colors.black,
  );

  static TextStyle subHeading = GoogleFonts.poppins(
    fontSize: subtitleFontSize,
    color: Colors.grey[800],
    fontWeight: FontWeight.w500,
  );
}
