import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/hlck_app_bar.dart';
import '../home/home.dart';
import '../wishlist/wishlist_screen.dart';
import '../profile/account_screen.dart';
import '../../models/product.dart';
import '../cart/cart_screen.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  Future<void> _addToCart(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please log in to add items to your cart.')),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('cart')
          .add({
        'name': product.name,
        'price': product.price,
        'imageUrl': product.imageUrl,
        'category': product.category,
        'description': product.description,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Added to cart!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add to cart: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const HLCKAppBar(title: 'hlck'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: product.imageUrl?.isNotEmpty == true
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          product.imageUrl ?? '',
                          fit: BoxFit.contain,
                        ),
                      )
                    : const Center(
                        child: Icon(Icons.image, size: 100, color: Colors.grey),
                      ),
              ),
              const SizedBox(height: 24),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '₱${product.price}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                product.description ?? 'No description available.',
                style: const TextStyle(fontSize: 15, color: Colors.black87),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  'Add to:',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () => _addToCart(context),
                      child: const Text('CART'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () {
                        // Add to wishlist logic here
                      },
                      child: const Text('WISHLIST'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomePage()),
              );
              break;
            case 1:
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const WishlistScreen()),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const AccountScreen()),
              );
              break;
          }
        },
      ),
    );
  }
}

class SalesOverview extends StatelessWidget {
  const SalesOverview({super.key});

  Future<List<Map<String, dynamic>>> _fetchSalesData() async {
    final ordersSnapshot =
        await FirebaseFirestore.instance.collection('orders').get();

    final Map<String, Map<String, dynamic>> salesMap = {};

    for (var orderDoc in ordersSnapshot.docs) {
      final orderData = orderDoc.data();
      final orderDate =
          orderData['date'] is Timestamp ? orderData['date'].toDate() : null;
      final products = orderData['products'];
      if (products is! List) continue;

      for (var prod in products) {
        if (prod is! Map) continue;
        final name = prod['name']?.toString() ?? '';
        if (name.isEmpty) continue;
        final category = prod['category']?.toString() ?? '';
        final priceStr = prod['price']?.toString() ?? '0';
        final price =
            double.tryParse(priceStr.replaceAll('₱', '').replaceAll(',', '')) ??
                0;
        final quantity = int.tryParse(prod['quantity']?.toString() ?? '1') ?? 1;

        if (!salesMap.containsKey(name)) {
          salesMap[name] = {
            'category': category,
            'sold': 0,
            'revenue': 0.0,
            'lastDate': orderDate,
            'price': priceStr,
          };
        }
        salesMap[name]!['sold'] += quantity;
        salesMap[name]!['revenue'] += price * quantity;
        if (orderDate != null &&
            (salesMap[name]!['lastDate'] == null ||
                orderDate.isAfter(salesMap[name]!['lastDate']))) {
          salesMap[name]!['lastDate'] = orderDate;
        }
      }
    }

    final salesList = salesMap.entries.map((e) {
      return {
        'name': e.key,
        'category': e.value['category'],
        'sold': e.value['sold'],
        'lastDate': e.value['lastDate'],
        'price': e.value['price'],
        'revenue': e.value['revenue'],
      };
    }).toList()
      ..sort((a, b) => (b['sold'] as int).compareTo(a['sold'] as int));

    return salesList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181A1B),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: 8),
              const Text(
                'Sales Overview',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: _fetchSalesData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                        child: Text('Error: ${snapshot.error}',
                            style: TextStyle(color: Colors.red)));
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final sales = snapshot.data!;
                  double totalRevenue = 0;
                  int totalSold = 0;
                  for (var sale in sales) {
                    totalRevenue += sale['revenue'] as double;
                    totalSold += sale['sold'] as int;
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _StatCard(label: 'Total Sold:', value: '$totalSold'),
                          const SizedBox(width: 16),
                          _StatCard(
                              label: 'Total Revenue:',
                              value: '₱${totalRevenue.toStringAsFixed(2)}'),
                        ],
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Product         Category     Sold     Last Date         Price',
                        style: TextStyle(
                            color: Colors.white70, fontWeight: FontWeight.bold),
                      ),
                      const Divider(color: Colors.white24),
                      if (sales.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Text('No sales yet.',
                              style: TextStyle(color: Colors.white70)),
                        ),
                      ...sales.map((sale) => _SalesRow(
                            product: sale['name'],
                            category: sale['category'],
                            sold: sale['sold'].toString(),
                            date: sale['lastDate'] != null
                                ? "${sale['lastDate'].month}/${sale['lastDate'].day}/${sale['lastDate'].year}"
                                : '-',
                            price: '₱${sale['price']}',
                          )),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF133024),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(Icons.monetization_on, color: Colors.white, size: 24),
            const SizedBox(width: 12),
            Text(label,
                style: const TextStyle(color: Colors.white, fontSize: 16)),
            const Spacer(),
            Text(value,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class _SalesRow extends StatelessWidget {
  final String product, category, sold, date, price;
  const _SalesRow(
      {required this.product,
      required this.category,
      required this.sold,
      required this.date,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
              child:
                  Text(product, style: const TextStyle(color: Colors.white))),
          const SizedBox(width: 8),
          Expanded(
              child:
                  Text(category, style: const TextStyle(color: Colors.white))),
          const SizedBox(width: 8),
          Expanded(
              child: Text(sold, style: const TextStyle(color: Colors.white))),
          const SizedBox(width: 8),
          Expanded(
              child: Text(date, style: const TextStyle(color: Colors.white))),
          const SizedBox(width: 8),
          Expanded(
              child: Text(price, style: const TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}
