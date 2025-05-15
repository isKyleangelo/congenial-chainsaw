import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/hlck_app_bar.dart';
import '../routes.dart';
import 'home/home.dart';
import 'wishlist/wishlist_screen.dart';
import 'profile/account_screen.dart';
import 'products/all_products_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const HLCKAppBar(
        title: 'HLCK',
        showBackButton: true,
        showCartIcon: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Shamrock icons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.eco, size: 60, color: Colors.green.shade400),
                const SizedBox(width: 20),
                Text(
                  'DONE!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
                ),
                const SizedBox(width: 20),
                Icon(Icons.eco, size: 60, color: Colors.green.shade400),
              ],
            ),
            const SizedBox(height: 50),
            // Home button
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntilWithTransition(
                    const HomePage(), (route) => false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                minimumSize: const Size(150, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text('HOME'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1, // Shop tab
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
              Navigator.of(context)
                  .pushReplacementWithTransition(const AccountScreen());
              break;
          }
        },
      ),
    );
  }
}
