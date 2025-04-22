import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/hlck_app_bar.dart';
import '../routes.dart';
import 'home.dart';
import 'all_products_screen.dart';
import 'account_screen.dart';
import 'oops_screen.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const HLCKAppBar(
        title: 'Wishlist',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Product item with cleaner layout
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product image
                    Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey.shade200,
                      child: const Center(
                        child: Text(
                          '[Image]',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    
                    // Product details in column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Barong na Mabangs',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '₱10,499',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Size: 9',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Add to cart button on the right
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushWithTransition(
                          const OopsScreen()
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        elevation: 0,
                        side: const BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      child: const Text(
                        'Add to cart',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 2, // Wishlist tab
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
              // Already in wishlist
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