import 'dart:async';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:ridersapp/authentication/auth_screen.dart';
import 'package:ridersapp/splash_screen/slider.dart'; // Import your slider screen

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  startTimer() {
    Timer(const Duration(seconds: 15), () async {
      // Navigate to the slider screen after 5 seconds
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MySliderScreen(),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();

    // Initialize animation controller and set up animation
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(1.0, -1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Start animation when the widget is built
    _animationController.forward();

    startTimer();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Change to spaceBetween
          children: [
            SlideTransition(
              position: _offsetAnimation,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Image.asset("images/sp3.png", height: 200),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.all(18),
              child: Text(
                "FOODFLOW",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFFDC652),
                  fontSize: 70,
                  fontFamily: "Signatra",
                  letterSpacing: 3,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Pakistan's no#1 food ordering app",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF56B89F),
                  fontSize: 40,
                  fontFamily: "Signatra",
                  letterSpacing: 3,
                ),
              ),
            ),
            const SizedBox(height: 10), // Add space between text and button
            ElevatedButton(
              onPressed: () {
                // Navigate to the slider screen when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MySliderScreen(),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xFFFDC652)),
              ),
              child: const Text(
                "Let's Go",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Signatra",
                  letterSpacing: 2,
                  fontSize: 35,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Image.asset(
                    "images/sp.png",
                    height: 140,
                    width: 140,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Image.asset(
                    "images/sp2.png",
                    height: 140,
                    width: 140,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
