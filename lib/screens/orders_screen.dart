import 'package:flutter/material.dart';
import '../widgets/hlck_app_bar.dart';
import '../widgets/common_drawer.dart';
import '../widgets/bottom_nav_bar.dart';
import '../routes.dart';
import 'home.dart';
import 'all_products_screen.dart';
import 'wishlist_screen.dart';
import 'account_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const HLCKAppBar(
        title: 'All purchases',
        showBackButton: true,
      ),
      drawer: const CommonDrawer(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              
              // No purchases message
              const Text(
                'No purchases to show right now',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              
              Text(
                'Once you have completed a purchase, you will find it here.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 40),
              
              // Shop button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntilWithTransition(
                      const HomePage(),
                      (route) => false
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text('Take me to fashion'),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3, // Account tab
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.of(context).pushReplacementWithTransition(
                const HomePage()
              );
              break;
            case 1:
              Navigator.of(context).pushReplacementWithTransition(
                const AllProductsScreen()
              );
              break;
            case 2:
              Navigator.of(context).pushReplacementWithTransition(
                const WishlistScreen()
              );
              break;
            case 3:
              Navigator.of(context).pushReplacementWithTransition(
                const AccountScreen()
              );
              break;
          }
        },
      ),
    );
  }
} 