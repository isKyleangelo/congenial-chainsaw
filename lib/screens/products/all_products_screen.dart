import 'package:flutter/material.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/hlck_app_bar.dart';
import '../../routes.dart';
import '../home/home.dart';
import '../wishlist/wishlist_screen.dart';
import '../profile/account_screen.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const HLCKAppBar(
        title: 'hlck',
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey[600]),
                  const SizedBox(width: 8.0),
                  Text(
                    'Search...',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Shamrock logo
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: 200,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.eco, size: 40, color: Colors.green.shade400),
                    const SizedBox(width: 8),
                    Icon(Icons.eco, size: 40, color: Colors.green.shade400),
                    const SizedBox(width: 8),
                    Icon(Icons.eco, size: 40, color: Colors.green.shade400),
                  ],
                ),
              ),
            ),
          ),

          // Filter and product count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                // Filter button
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.filter_list, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        'Filter',
                        style: TextStyle(color: Colors.grey.shade800),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // Product count
                Text(
                  '2 products',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Product grid
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildProductCard('Product 1'),
                _buildProductCard('Product 2'),
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
              // Already in shop tab
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

  Widget _buildProductCard(String title) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Product image
          Expanded(
            child: Container(
              color: Colors.grey.shade200,
              child: Center(
                child: Text(
                  '[Image]',
                  style: TextStyle(color: Colors.grey.shade500),
                ),
              ),
            ),
          ),
          // Product info
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
