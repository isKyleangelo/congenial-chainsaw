import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/hlck_app_bar.dart';
import '../../routes.dart';
import '../home/home.dart';
import 'all_products_screen.dart';
import '../wishlist/wishlist_screen.dart';
import '../profile/account_screen.dart';
import '../../../providers/product_provider.dart';

class CategoryScreen extends StatelessWidget {
  final String title;

  const CategoryScreen({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final allProducts = context.watch<ProductProvider>().products;
    final products = allProducts.where((p) =>
      p.category.replaceAll(' ', '').toLowerCase() ==
      title.replaceAll(' ', '').toLowerCase()
    ).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HLCKAppBar(
        title: title,
        showBackButton: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.6,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(
            name: product.name,
            price: product.price,
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

class ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final bool isStock;
  final bool isSale;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    this.isStock = true,
    this.isSale = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Product image with stock/sale badge
          Stack(
            children: [
              Container(
                height: 120,
                width: double.infinity,
                color: Colors.grey.shade200,
                child: const Center(
                  child: Text(
                    '[Product Image]',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              // Stock or Sale badge
              if (!isStock || isSale)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: !isStock ? Colors.red : Colors.green,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      !isStock ? 'OUT OF STOCK' : 'SALE',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          // Product details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: TextStyle(
                      color: isSale ? Colors.red : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(flex: 1),

                  // Add to cart button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isStock ? () {} : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        minimumSize: const Size.fromHeight(25),
                        textStyle: const TextStyle(fontSize: 12),
                      ),
                      child: const Text('ADD TO CART'),
                    ),
                  ),

                  // Wishlist button with heart icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        iconSize: 18,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _navigateToCategory(BuildContext context, String categoryName) {
  Navigator.of(context).pushWithTransition(
    CategoryScreen(title: categoryName),
  );
}
