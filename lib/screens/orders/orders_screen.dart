import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../routes.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/common_drawer.dart';
import '../../widgets/hlck_app_bar.dart';
import '../home/home.dart';
import '../products/all_products_screen.dart';
import '../profile/account_screen.dart';
import '../wishlist/wishlist_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const HLCKAppBar(
        title: 'All purchases',
        showBackButton: true,
      ),
      drawer: const CommonDrawer(),
      body: user == null
          ? const Center(child: Text('Please log in to view your purchases.'))
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('orders')
                  .where('userId', isEqualTo: user.uid)
                  .orderBy('date', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40),
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
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamedAndRemoveUntilWithTransition(
                                        const HomePage(), (route) => false);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
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
                  );
                }

                // Gather all products from all orders
                final orders = snapshot.data!.docs;
                List<Map<String, dynamic>> allProducts = [];
                double grandTotal = 0;

                for (var order in orders) {
                  final products = order['products'] as List<dynamic>? ?? [];
                  for (var prod in products) {
                    if (prod is Map<String, dynamic>) {
                      allProducts.add(prod);
                      final price = double.tryParse(prod['price']
                              .toString()
                              .replaceAll('₱', '')
                              .replaceAll(',', '')) ??
                          0;
                      final qty =
                          int.tryParse(prod['quantity']?.toString() ?? '1') ??
                              1;
                      grandTotal += price * qty;
                    }
                  }
                }

                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Your Purchases',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.separated(
                          itemCount: allProducts.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (context, index) {
                            final item = allProducts[index];
                            final qty = int.tryParse(
                                    item['quantity']?.toString() ?? '1') ??
                                1;
                            return ListTile(
                              leading: item['imageUrl'] != null &&
                                      item['imageUrl'].toString().isNotEmpty
                                  ? Image.network(item['imageUrl'],
                                      width: 48, height: 48, fit: BoxFit.cover)
                                  : const Icon(Icons.image,
                                      size: 48, color: Colors.grey),
                              title: Text(item['name'] ?? 'Product'),
                              subtitle: Text('₱${item['price']}  x$qty'),
                              trailing: Text(
                                '₱${((double.tryParse(item['price'].toString().replaceAll('₱', '').replaceAll(',', '')) ?? 0) * qty).toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Spent:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '₱${grandTotal.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3, // Account tab
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
