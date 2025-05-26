import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/product_provider.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/hlck_app_bar.dart';
import '../home/home.dart';
import '../wishlist/wishlist_screen.dart';
import '../profile/account_screen.dart';
import '../../models/product.dart';
import '../products/product_details_screen.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  String _searchQuery = '';
  String _sortOption = 'A-Z';

  List<Product> _sortProducts(List<Product> products) {
    List<Product> sorted = List<Product>.from(products);
    if (_sortOption == 'A-Z') {
      sorted
          .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    } else if (_sortOption == 'By Price') {
      sorted.sort((a, b) {
        double priceA =
            double.tryParse(a.price.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0;
        double priceB =
            double.tryParse(b.price.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0;
        return priceA.compareTo(priceB);
      });
    }
    return sorted;
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ProductProvider>().fetchProducts());
  }

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductProvider>().products;
    final filteredProducts = products
        .where((product) =>
            product.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
    final sortedProducts = _sortProducts(filteredProducts);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const HLCKAppBar(title: 'hlck'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Container(
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
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Search...',
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                DropdownButton<String>(
                  value: _sortOption,
                  underline: const SizedBox(),
                  style: TextStyle(color: Colors.grey.shade800, fontSize: 14),
                  borderRadius: BorderRadius.circular(4),
                  items: const [
                    DropdownMenuItem(
                      value: 'A-Z',
                      child: Row(
                        children: [
                          Icon(Icons.sort_by_alpha, size: 18),
                          SizedBox(width: 4),
                          Text('A-Z'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'By Price',
                      child: Row(
                        children: [
                          Icon(Icons.attach_money, size: 18),
                          SizedBox(width: 4),
                          Text('By Price'),
                        ],
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _sortOption = value!;
                    });
                  },
                ),
                const Spacer(),
                Text(
                  '${sortedProducts.length} product${sortedProducts.length != 1 ? 's' : ''}',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: sortedProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final product = sortedProducts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ProductDetailsScreen(product: product),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12)),
                              child: product.imageBytes != null
                                  ? Image.memory(
                                      product.imageBytes!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    )
                                  : product.imageUrl != null && product.imageUrl!.startsWith('http')
                                      ? Image.network(
                                          product.imageUrl!,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        )
                                      : product.imageUrl != null && product.imageUrl!.isNotEmpty
                                          ? Image.asset(
                                              product.imageUrl!,
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              height: double.infinity,
                                            )
                                          : Container(
                                              color: Colors.grey[200],
                                              child: const Icon(Icons.image, size: 48, color: Colors.grey),
                                            ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  product.price,
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => const HomePage()));
              break;
            case 1:
              break;
            case 2:
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const WishlistScreen()));
              break;
            case 3:
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const AccountScreen()));
              break;
          }
        },
      ),
    );
  }
}
