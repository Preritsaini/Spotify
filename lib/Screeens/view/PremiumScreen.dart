import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Dashboard.dart';
import 'LibraryScreen.dart';
import 'SearchScreen.dart';

class Premiumscreen extends StatefulWidget {
  const Premiumscreen({Key? key}) : super(key: key);

  @override
  State<Premiumscreen> createState() => _PremiumscreenState();
}

class _PremiumscreenState extends State<Premiumscreen> {
  int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Go Premium",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Premium Banner
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [Colors.orange, Colors.black],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    "Enjoy Ad-Free Music",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Unlock exclusive features with our premium subscription!",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    "assets/images/Icon.png", // Replace with your image path
                    height: 150,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Subscription Plans
            const Text(
              "Choose Your Plan",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Plan Cards
            _buildPlanCard(
              title: "Monthly Plan",
              price: "\$4.99/month",
              description: "Ad-free experience, offline playback, and more.",
            ),
            const SizedBox(height: 16),
            _buildPlanCard(
              title: "Yearly Plan",
              price: "\$49.99/year",
              description: "Save 20%! Get all premium features for a year.",
              highlight: true,
            ),
            const SizedBox(height: 30),

            // Subscribe Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: ElevatedButton(
                onPressed: () {
                  // Handle subscription action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "Subscribe Now",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        elevation: 0,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            if (index == 0) {
              Get.to(Dashboard());
            } else if (index == 1) {
              Get.to(Searchscreen());
            } else if (index == 2) {
              Get.to(const Libraryscreen());
            } else if (index == 3) {
              Get.to(const Premiumscreen());
            }
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: "Library",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.workspace_premium),
            label: "Premium",
          ),
        ],
      ),
    );
  }

  // Helper Widget to Build Subscription Plan Card
  Widget _buildPlanCard({
    required String title,
    required String price,
    required String description,
    bool highlight = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: highlight ? Colors.orange : Colors.white10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: highlight ? Colors.black : Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            price,
            style: TextStyle(
              color: highlight ? Colors.black87 : Colors.white70,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              color: highlight ? Colors.black54 : Colors.white54,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
