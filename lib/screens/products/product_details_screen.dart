import 'package:flutter/material.dart';
import '../../widgets/base_screen.dart';
import '../home/home.dart';
import 'all_products_screen.dart';
import '../wishlist/wishlist_screen.dart';
import '../profile/account_screen.dart';
import '../../models/product.dart'; // import your model
import '../../routes.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  final VoidCallback? onAddToCart;
  final VoidCallback? onAddToWishlist;

  const ProductDetailsScreen({
    super.key,
    required this.product,
    this.onAddToCart,
    this.onAddToWishlist,
  });

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: '',
      showBackButton: true,
      showCartIcon: false,
      currentNavIndex: 1,
      onNavTap: (index) {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Product image
              Container(
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: product.imageUrl.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          product.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Center(
                        child: Icon(Icons.image, size: 80, color: Colors.grey),
                      ),
              ),
              const SizedBox(height: 24),

              // Product name and price
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
                    ),
                  ),
                  Text(
                    product.price,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Description
              Text(
                product.description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),

              const Text(
                'Add to:',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 12),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onAddToCart ?? () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('CART'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onAddToWishlist ?? () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade100,
                        foregroundColor: Colors.green.shade900,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('WISHLIST'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> allProducts = [
  // ...other products
  {
    'name': 'White Logo Shirt',
    'price': '₱1,299',
    'isStock': true,
    'isSale': false,
    'imageUrl': 'assets/images/onlyin_hlck/white_logo1.png',
    'description': 'Exclusive HLCK white logo shirt. Only available here!',
  },
];
