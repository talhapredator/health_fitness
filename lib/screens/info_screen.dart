import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class InfoScreen extends StatelessWidget {
  final List<String> images = [
    'assets/images/info-1.jpg', // Add your images here
    'assets/images/info-2.jpg', // Image shown in the middle
    'assets/images/fitness-1.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 50), // Space at the top
            // Title
            Text(
              "What is your goal?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            // Subtitle
            Text(
              "It will help us to choose the best program for you",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),

            // Image carousel with the same background color as shown
            CarouselSlider(
              options: CarouselOptions(
                height: 400, // Adjust as needed
                enableInfiniteScroll: true,
                enlargeCenterPage: true,
              ),
              items: images.map((imagePath) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [Colors.blue[200]!, Colors.purpleAccent[100]!],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            imagePath,
                            height: 200, // Adjust image size
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Improve Shape",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "I have a low amount of body fat\nand need / want to build more muscle",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,

                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            SizedBox(height: 40),

            // Confirm Button
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: GestureDetector(
                onTap: () {
                  // Handle confirmation action
                  Navigator.pushReplacementNamed(context, '/next_screen');
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.purpleAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
