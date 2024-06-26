import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ridersapp/authentication/auth_screen.dart';
import 'package:ridersapp/global/global.dart';
// import 'package:ridersapp/home_screen/main_screen.dart';

import '../mainScreens/home-screen.dart';

class MySliderScreen extends StatefulWidget {
  const MySliderScreen({Key? key}) : super(key: key);

  @override
  _MySliderScreenState createState() => _MySliderScreenState();
}

class _MySliderScreenState extends State<MySliderScreen> {
  late CarouselController _carouselController;
  late int _currentSlideIndex;
  bool _sliderCompleted = false; // Flag to track if slider is completed

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselController();
    _currentSlideIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 60, 116, 164),
      body: !_sliderCompleted // Display slider only if not completed
          ? Stack(
        children: [
          CarouselSlider(
            carouselController: _carouselController,
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height,
              enableInfiniteScroll: false,
              viewportFraction: 1.0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration:
              const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentSlideIndex = index;
                });
              },
            ),
            items: [
              // Slide items...
              _buildSliderItem(
                image: 'images/one.png',
                imageSize: const Size(250, 250),
                heading: 'ORDER',
                description: 'Discover thousands of restaurants',
              ),
              _buildSliderItem(
                image: 'images/two.png',
                imageSize: const Size(250, 250),
                heading: 'TRACK',
                description: 'Stay safe with contactless delivery',
              ),
              _buildSliderItem(
                image: 'images/three.png',
                imageSize: const Size(250, 250),
                heading: 'Browse',
                description: 'Shop from your favourite',
              ),
              _buildSliderItem(
                image: 'images/four.png',
                imageSize: const Size(250, 250),
                heading: 'Fast delivery',
                description: 'Get what you need delivered fast',
              ),
              _buildSliderItem(
                image: 'images/five.png',
                imageSize: const Size(250, 250),
                heading: 'Safe delivery',
                description: 'Cash on delivery',
                isLastSlide: true,
              ),
            ],
          ),
          Positioned(
            bottom: 20.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                    (index) => Container(
                  width: 10.0,
                  height: 10.0,
                  margin:
                  const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index == _currentSlideIndex
                        ? const Color(0xFFFDC652)
                        : const Color(0xFF56B89F),
                  ),
                ),
              ),
            ),
          ),
        ],
      )
          : Center(
        // Display something else when slider is completed
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (c) => const AuthScreen()),
            );
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
          ),
          child: const Text(
            "Get Started",
            style: TextStyle(
              fontFamily: 'Signatra',
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSliderItem({
    String? image,
    Size? imageSize,
    String? heading,
    String? description,
    bool isLastSlide = false,
  }) {
    return GestureDetector(
      onTap: () {
        if (isLastSlide) {
          if (firebaseAuth.currentUser != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (c) => const HomeScreen()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (c) => const AuthScreen()),
            );
          }
        } else {
          _carouselController.nextPage();
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image!,
              width: imageSize!.width,
              height: imageSize.height,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20.0),
            Text(
              heading!,
              style: const TextStyle(
                  fontSize: 34.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 20.0),
            Text(
              description!,
              style: const TextStyle(fontSize: 24.0, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40.0),
            if (isLastSlide)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => const AuthScreen()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.black,
                  ),
                ),
                child: const Text(
                  "Get Started",
                  style: TextStyle(
                    fontFamily: 'Signatra',
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
