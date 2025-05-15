import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/hlck_app_bar.dart';
import '../routes.dart';
import 'home/home.dart';
import 'products/all_products_screen.dart';
import 'wishlist/wishlist_screen.dart';
import 'auth/login_screen.dart';

class OopsScreen extends StatelessWidget {
  const OopsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const HLCKAppBar(
        title: 'HLCK',
        showBackButton: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Sold out circular badge
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    'SOLD OUT',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Error message
              Text(
                'Oops! It seems you don\'t have an account.',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'Create one?',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // CREATE button
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushWithTransition(const LoginScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'CREATE',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // HOME button
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementWithTransition(const HomePage());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade200,
                    foregroundColor: Colors.black54,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'HOME',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3, // Account tab (since this is an account-related error)
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.of(context)
                  .pushReplacementWithTransition(const HomePage());
              break;
            case 1:
              Navigator.of(context)
                  .pushReplacementWithTransition(const AllProductsScreen());
              break;
            case 2:
              Navigator.of(context)
                  .pushReplacementWithTransition(const WishlistScreen());
              break;
            case 3:
              // Already in account section
              break;
          }
        },
      ),
    );
  }
}
