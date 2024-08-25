import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'on_boarding_data.dart';

class OnBoardingCard extends StatefulWidget {
  final OnBoarding onBoardingModel;

  const OnBoardingCard({
    super.key,
    required this.onBoardingModel,
  });

  @override
  State<OnBoardingCard> createState() => _OnBoardingCardState();
}

class _OnBoardingCardState extends State<OnBoardingCard> {
  @override
  Widget build(BuildContext context) {
    print(widget.onBoardingModel.image);
    return Lottie.asset(
      widget.onBoardingModel.image,
      width: 100,
      fit: BoxFit.contain,
    );
  }
}

class OnboardingTextCard extends StatelessWidget {
  final OnBoarding onBoardingModel;

  const OnboardingTextCard({required this.onBoardingModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Column(
        children: [
          Text(
            onBoardingModel.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary
            ),
          ),
          const SizedBox(height: 16),
          Text(
            onBoardingModel.description,
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(.7),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}