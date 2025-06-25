import 'package:ecommerce/features/authentication/views/login.dart';
import 'package:ecommerce/features/onboarding/views/onboardingwidget.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboardingmain extends StatefulWidget {
  const Onboardingmain({super.key});

  @override
  State<Onboardingmain> createState() => _OnboardingmainState();
}

class _OnboardingmainState extends State<Onboardingmain> {
  // list of the onbaording content
  List onBoardingScreenInfo = [
    [
      "assets/illustrations/find.jpg",
      "Choose Your Product",
      "Welcome to the World of Limitless Choices - Your Perfect Product Awaits",
    ],
    [
      "assets/illustrations/cart.jpg",
      "Select Payment Method",
      "For Seemless Transaction, Choose Your Payment Path - Your Convenience our priority",
    ],
    [
      "assets/illustrations/delivery.jpg",
      "Deliver At Your House Door",
      "Form Our Doorstep to yours - Swift , Secure and Contactless Delivery!",
    ],
  ];

  // current index
  int currentIndex = 0;

  // page controller
  final _onBoardingController = PageController();

  // method to skip the onbaording onBoardingScreen
  void _skip() {
    _onBoardingController.animateToPage(
      onBoardingScreenInfo.length - 1,
      duration: Duration(milliseconds: 600),
      curve: Curves.easeIn,
    );
  }

  // method to skip to next page
  void _nextPage() {
    if (currentIndex < onBoardingScreenInfo.length - 1) {
      _onBoardingController.nextPage(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    }
  }

  // method to go to login page after finish appears
  void _finishButton() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 15,
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // onbording widget
          PageView.builder(
            controller: _onBoardingController,
            allowImplicitScrolling: true,
            itemCount: onBoardingScreenInfo.length,
            itemBuilder: (context, index) => Onboardingwidget(
              image: onBoardingScreenInfo[index][0],
              title: onBoardingScreenInfo[index][1],
              discription: onBoardingScreenInfo[index][2],
            ),
            onPageChanged: (index) => {
              setState(() {
                currentIndex = index;
              }),
            },
          ),

          // floating button
          Positioned(
            right: 15,
            bottom: 30,
            child: currentIndex == onBoardingScreenInfo.length - 1
                ? FloatingActionButton(
                    shape: CircleBorder(),
                    backgroundColor: Colors.red.shade400,
                    onPressed: _finishButton,
                    child: Icon(Icons.arrow_right_alt, size: 30),
                  )
                : FloatingActionButton(
                    shape: CircleBorder(),
                    backgroundColor: Colors.red.shade400,
                    onPressed: _nextPage,
                    child: Icon(Icons.arrow_right_alt, size: 30),
                  ),
          ),

          // skip button
          Positioned(
            top: 0,
            right: 15,
            child: TextButton(
              onPressed: _skip,
              child: Text("Skip", style: TextStyle(color: Colors.black)),
            ),
          ),

          // indicator
          Positioned(
            left: 15,
            bottom: 50,
            child: SmoothPageIndicator(
              controller: _onBoardingController,
              count: onBoardingScreenInfo.length,
              effect: WormEffect(
                activeDotColor: Colors.red.shade400,
                dotHeight: 10,
                dotWidth: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
