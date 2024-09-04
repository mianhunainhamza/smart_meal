import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_meal/screens/auth/login_page.dart';
import 'package:smart_meal/widgets/custom_button.dart';
import 'components/on_boarding_card.dart';
import 'components/on_boarding_data.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController1 = PageController(initialPage: 0);
  final PageController _pageController2 = PageController(initialPage: 0);
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Container(
            height: 10,
            width: 10,
            margin: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Theme
                  .of(context)
                  .colorScheme
                  .primary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            flex: 3,
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: onBoardinglist.length,
              physics: const BouncingScrollPhysics(),
              controller: _pageController1,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return OnBoardingCard(
                  onBoardingModel: onBoardinglist[index],
                );
              },
            ),
          ),
          const SizedBox(height: 100),
          Center(
            child: DotsIndicator(
              dotsCount: onBoardinglist.length,
              position: _currentIndex,
              decorator: DotsDecorator(
                size: const Size.square(8.0),
                activeSize: const Size(20.0, 8.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: Theme
                    .of(context)
                    .colorScheme
                    .onPrimary,
                // Black color
                activeColor:
                Theme
                    .of(context)
                    .colorScheme
                    .primary, // Primary color
              ),
            ),
          ),
          const SizedBox(height: 37),
          Expanded(
            flex: 3,
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: onBoardinglist.length,
              physics: const BouncingScrollPhysics(),
              controller: _pageController2,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return OnboardingTextCard(
                  onBoardingModel: onBoardinglist[index],
                );
              },
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 23, bottom: 36),
            child: CustomButton(
              onPressed: () {
                if (_currentIndex == onBoardinglist.length - 1) {
                  Get.offAll(() => const LoginScreen(),transition: Transition.cupertino);
                } else {
                  // Continue to the next page
                  _pageController1.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                  );
                  _pageController2.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                  );
                }
              },
              text: _currentIndex == onBoardinglist.length - 1
            ? 'Get Started'
              : 'Next',
              backgroundColor: Theme
                  .of(context)
                  .colorScheme
                  .primary,
              textColor: Theme
                  .of(context)
                  .colorScheme
                  .onPrimary, isLoading: false, tag: 'onboard',
              // White color
            ),
          ),
        ],
      ),
    );
  }
}

