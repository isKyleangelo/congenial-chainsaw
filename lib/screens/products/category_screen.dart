import 'package:flutter/material.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/hlck_app_bar.dart';

class CategoryScreen extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> products;

  const CategoryScreen({
    super.key,
    required this.title,
<<<<<<< HEAD
    required this.products,
=======
    required List<Map<String, Object>> products,
>>>>>>> dd75630cb1ddbd11d31907c07c8f69d7b0f439c1
  });

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
=======
    final allProducts = context.watch<ProductProvider>().products;
    final products = allProducts
        .where((p) =>
            p.category.replaceAll(' ', '').toLowerCase() ==
            title.replaceAll(' ', '').toLowerCase())
        .toList();

>>>>>>> dd75630cb1ddbd11d31907c07c8f69d7b0f439c1
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
            name: product['name'],
            price: product['price'],
            isStock: product['isStock'],
            isSale: product['isSale'],
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/shop');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/cart');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/account');
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
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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

<<<<<<< HEAD
void navigateToCategory(BuildContext context, String categoryName, List<Map<String, dynamic>> products) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CategoryScreen(
        title: categoryName,
        products: products,
      ),
=======
void _navigateToCategory(BuildContext context, String categoryName) {
  Navigator.of(context).pushWithTransition(
    CategoryScreen(
      title: categoryName,
      products: [],
>>>>>>> dd75630cb1ddbd11d31907c07c8f69d7b0f439c1
    ),
  );
}