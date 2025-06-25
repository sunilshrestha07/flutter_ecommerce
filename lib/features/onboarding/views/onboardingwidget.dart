import 'package:flutter/material.dart';

class Onboardingwidget extends StatelessWidget {
  final String image;
  final String title;
  final String discription;
  const Onboardingwidget({
    super.key,
    required this.image,
    required this.title,
    required this.discription,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // Container for the image
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 50, horizontal: 60),
                child: Image.asset(image, fit: BoxFit.cover),
              ),
            ),

            // sized box for the gap
            SizedBox(height: 30),

            // title text
            Text(
              title,
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),

            // discription text
            Text(
              discription,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
