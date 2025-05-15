import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/hlck_app_bar.dart';
import '../routes.dart';
import 'checkout_screen.dart';
import 'home/home.dart';
import 'wishlist/wishlist_screen.dart';
import 'profile/account_screen.dart';
import 'products/all_products_screen.dart';

class ConfirmCheckoutScreen extends StatelessWidget {
  const ConfirmCheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const HLCKAppBar(
        title: 'Confirm Order',
        showBackButton: true,
        showCartIcon: false,
      ),
      body: Stack(
        children: [
          // Decorative shamrocks
          Positioned(
            top: 50,
            left: 20,
            child: Icon(Icons.eco, size: 40, color: Colors.green.shade300),
          ),
          Positioned(
            top: 30,
            right: 40,
            child: Icon(Icons.eco, size: 30, color: Colors.green.shade300),
          ),
          Positioned(
            top: 80,
            right: 20,
            child: Icon(Icons.eco, size: 40, color: Colors.green.shade300),
          ),

          // Main content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 100), // Space for shamrocks

                // Order summary card
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Item with image
                        Row(
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

                            // Item details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Item 1',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    '₱4,999',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),
                        const Divider(),

                        // Shipping information
                        const Text(
                          'Shipping Address',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Your name',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            const Text('John Doe'),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // Contact information
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Contact Number',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            const Text('09123456789'),
                          ],
                        ),

                        const SizedBox(height: 20),
                        const Divider(),

                        // Payment method
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Method of Payment',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            const Text('Cash'),
                          ],
                        ),

                        const SizedBox(height: 20),
                        const Divider(),

                        // Total
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '₱4,999',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.red.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Confirm checkout button
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushWithTransition(const CheckoutScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'CONFIRM ORDER',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
