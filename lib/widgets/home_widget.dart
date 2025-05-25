import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'bottom_nav_bar.dart';
import 'hlck_app_bar.dart';
import 'common_drawer.dart';
import '../screens/products/category_screen.dart';
import '../screens/products/all_products_screen.dart';
import '../screens/wishlist/wishlist_screen.dart';
import '../screens/profile/account_screen.dart';
import '../routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> latestProducts = [];

  @override
  void initState() {
    super.initState();
    _loadLatestProducts();
  }

  Future<void> _loadLatestProducts() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('products')
        .orderBy('createdAt', descending: true)
        .limit(2)
        .get();

    setState(() {
      latestProducts = snapshot.docs
          .map((doc) => {
                ...doc.data() as Map<String, dynamic>,
                'id': doc.id,
              })
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const HLCKAppBar(),
      drawer: const CommonDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16.0),
              _buildSearchBar(),
              const SizedBox(height: 16.0),
              _buildBanner(),
              const SizedBox(height: 16.0),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio:
                    0.95, // Adjust this value as needed (1.0 is square)
                children: const [
                  CategoryItem(title: 'Plain Tee'),
                  CategoryItem(title: 'Hoodies'),
                  CategoryItem(title: 'Graphic Tee'),
                  CategoryItem(title: 'Only in\nHLCK'),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0, bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Latest Drops',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => const AllProductsScreen()),
                        );
                      },
                      child: const Text(
                        'Shop All',
                        style: TextStyle(color: Colors.black, fontSize: 14.0),
                      ),
                    ),
                  ],
                ),
              ),
              _buildLatestDrops(),
              const SizedBox(height: 24.0),
              _buildPromoBanner(),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              break;
            case 1:
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const AllProductsScreen()),
              );
              break;
            case 2:
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const WishlistScreen()),
              );
              break;
            case 3:
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const AccountScreen()),
              );
              break;
          }
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey[600]),
          const SizedBox(width: 8.0),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14.0),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(bottom: 6.8),
              ),
              onChanged: (value) {
                print('Search query: \$value');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: const Center(
        child: Text(
          '[Featured Image Placeholder]',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.pink[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Fanny Packs?',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              minimumSize: const Size(120, 36),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('SHOP NOW'),
          ),
        ],
      ),
    );
  }

  Widget _buildLatestDrops() {
    return SizedBox(
      height: 180,
      child: latestProducts.isEmpty
          ? const Center(child: Text("No products yet"))
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: latestProducts.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final product = latestProducts[index];
                print('Product image URL: ${product['imageUrl']}');
                return LatestDropItem(
                  name: product['name'],
                  price: product['price'].toString(),
                  imageUrl: product['imageUrl'],
                );
              },
            ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String title;

  const CategoryItem({
    super.key,
    required this.title,
  });

  String get _imagePath {
    if (title == 'Plain Tee') {
      return 'images/plain/plain_olive.png';
    } else if (title == 'Hoodies') {
      return 'images/hoodie/risktaker.png';
    } else if (title == 'Graphic Tee') {
      return 'images/graphic_tee/moneybank.png';
    } else if (title == 'Only in\nHLCK') {
      return 'images/onlyin_hlck/white_logo1.png';
    }
    return '';
  }

  String get _categoryName {
    if (title == 'Plain Tee') return 'plain';
    if (title == 'Hoodies') return 'hoodies';
    if (title == 'Graphic Tee') return 'graphic tees';
    if (title == 'Only in\nHLCK') return 'OG';
    return title.toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return InkWell(
          borderRadius: BorderRadius.circular(8.0),
          onTap: () => _navigateToCategory(context, _categoryName),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    _imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(color: Colors.grey[300]);
                    },
                  ),
                ),
                Center(
                  child: Container(
                    color: Colors.white.withOpacity(
                        0.2), // 20% transparent background for label
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Performa',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        letterSpacing: 1,
                        shadows: [
                          Shadow(
                            color: Colors.white,
                            blurRadius: 8,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

void _navigateToCategory(BuildContext context, String categoryName) {
  if (categoryName == 'Only in HLCK' || categoryName == 'Only in\nHLCK') {
    final onlyInHlckProducts = [
      {
        'name': 'White Logo Shirt',
        'price': '₱1,299',
        'isStock': true,
        'isSale': false,
        'imageUrl': 'assets/images/onlyin_hlck/white_logo1.png',
        'description': 'Exclusive HLCK white logo shirt. Only available here!',
      },
    ];
    Navigator.of(context).pushWithTransition(
      CategoryScreen(title: categoryName, products: onlyInHlckProducts),
    );
    return;
  }

  final sampleProducts = List.generate(4, (index) {
    return {
      'name': '${categoryName.split(' ')[0]} ${index + 1}',
      'price': '₱${999 + (index * 100)}',
      'isStock': index % 3 != 2,
      'isSale': index % 2 == 0,
      'imageUrl':
          'assets/images/sample_product.png', // <-- Add a valid image path
      'description':
          'Sample description for ${categoryName.split(' ')[0]} ${index + 1}', // <-- Add a description
    };
  });

  Navigator.of(context).pushWithTransition(
    CategoryScreen(title: categoryName, products: sampleProducts),
  );
}

class LatestDropItem extends StatelessWidget {
  final String name;
  final String price;
  final String imageUrl;

  const LatestDropItem({
    super.key,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'latest-drop-$name',
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AllProductsScreen()),
          );
        },
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                imageUrl,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
              ),
              const SizedBox(height: 8),
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '₱$price',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
