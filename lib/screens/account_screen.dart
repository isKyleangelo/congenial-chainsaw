import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/hlck_app_bar.dart';
import '../widgets/common_drawer.dart';
import '../routes.dart';
import 'home.dart';
import 'all_products_screen.dart';
import 'wishlist_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'profile_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const HLCKAppBar(
        title: 'Account',
      ),
      drawer: const CommonDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.account_circle,
              size: 100,
              color: Colors.black26,
            ),
            const SizedBox(height: 24),
            Text(
              'You need to login to access your account',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 40),
            
            // Login/Create account buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushWithTransition(
                      const LoginScreen()
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: const Text('LOGIN'),
                ),
                const SizedBox(width: 16),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushWithTransition(
                      const RegisterScreen()
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: const Text('SIGN UP'),
                ),
              ],
            ),
          ],
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
              // Already in account
              break;
          }
        },
      ),
    );
  }
} 