import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/hlck_app_bar.dart';
import '../routes.dart';
import 'home/home.dart';
import 'wishlist/wishlist_screen.dart';
import 'profile/account_screen.dart';
import 'products/all_products_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  Future<Map<String, dynamic>?> _getUserData(String uid) async {
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return doc.data();
  }

  Future<List<Map<String, dynamic>>> _getCartItems(String uid) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('cart')
        .get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Scaffold(
        appBar: const HLCKAppBar(
          title: 'HLCK',
          showBackButton: true,
          showCartIcon: false,
        ),
        body: const Center(child: Text('Please log in to checkout.')),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const HLCKAppBar(
        title: 'HLCK',
        showBackButton: true,
        showCartIcon: false,
      ),
      body: FutureBuilder(
        future: Future.wait([
          _getUserData(user.uid),
          _getCartItems(user.uid),
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final userData = snapshot.data![0] as Map<String, dynamic>?;
          final cartItems = snapshot.data![1] as List<Map<String, dynamic>>;

          final email = user.email ?? '';
          final address = userData?['address'] ?? '';
          double total = 0;
          for (var item in cartItems) {
            final price = double.tryParse(item['price']
                    .toString()
                    .replaceAll('₱', '')
                    .replaceAll(',', '')) ??
                0;
            total += price;
          }

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // User info
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email: $email',
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text('Address: ',
                                style: TextStyle(fontSize: 16)),
                            Expanded(
                              child: Text(
                                address.isNotEmpty ? address : 'No address set',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: address.isNotEmpty
                                      ? Colors.black
                                      : Colors.red,
                                ),
                              ),
                            ),
                            if (address.isEmpty)
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushWithTransition(
                                      const AccountScreen());
                                },
                                child: const Text('Set Address'),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Cart items
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: cartItems.isEmpty
                          ? const Center(child: Text('Your cart is empty.'))
                          : ListView.separated(
                              itemCount: cartItems.length,
                              separatorBuilder: (_, __) => const Divider(),
                              itemBuilder: (context, index) {
                                final item = cartItems[index];
                                return Row(
                                  children: [
                                    if (item['imageUrl'] != null &&
                                        item['imageUrl'].toString().isNotEmpty)
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: Image.network(
                                          item['imageUrl'],
                                          width: 48,
                                          height: 48,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    else
                                      Container(
                                        width: 48,
                                        height: 48,
                                        color: Colors.grey[300],
                                        child:
                                            const Icon(Icons.image, size: 24),
                                      ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        item['name'] ?? 'Item',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      '₱${item['price']}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                );
                              },
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Total
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('₱${total.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 20),

                // Proceed button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (address.isEmpty || cartItems.isEmpty)
                        ? null
                        : () async {
                            final confirmed = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Confirm Checkout'),
                                content: const Text(
                                    'Are you sure you want to checkout these products?'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: const Text('Proceed'),
                                  ),
                                ],
                              ),
                            );
                            if (confirmed == true) {
                              // Here you can add order creation logic if needed
                              // Clear the cart
                              final cartRef = FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(user.uid)
                                  .collection('cart');
                              final cartSnapshot = await cartRef.get();
                              for (var doc in cartSnapshot.docs) {
                                await doc.reference.delete();
                              }
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Checkout successful!')),
                                );
                                Navigator.of(context)
                                    .pushReplacementWithTransition(
                                        const HomePage());
                              }
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text('Proceed to Checkout'),
                  ),
                ),
              ],
            ),
          );
        },
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
