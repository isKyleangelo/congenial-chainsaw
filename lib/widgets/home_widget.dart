import 'dart:ui';
import 'package:flutter/material.dart';
import 'bottom_nav_bar.dart';
import 'hlck_app_bar.dart';
import 'common_drawer.dart';
import '../screens/products/category_screen.dart';
import '../screens/products/all_products_screen.dart';
import '../screens/wishlist/wishlist_screen.dart';
import '../screens/profile/account_screen.dart';
import '../routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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

              // Search Bar
              _buildSearchBar(),

              // Featured Banner Placeholder
              Container(
                height: 240,
                margin: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Center(
                  child: Text(
                    '[Featured Image Placeholder]',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),

              // Category Grid
              SizedBox(
                height: 250, // Adjust as needed
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    CategoryItem(title: 'Plain Tee'),
                    CategoryItem(title: 'Hoodies'),
                    CategoryItem(title: 'Graphic Tee'),
                    CategoryItem(title: 'Only in\nHLCK'),
                  ],
                ),
              ),

              // Latest Drops Heading
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
                          MaterialPageRoute(builder: (_) => const AllProductsScreen()),
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

              // Latest Drops Items
              SizedBox(
                height: 180, // Adjust as needed
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    LatestDropItem(),
                    LatestDropItem(),
                  ],
                ),
              ),

              // Fanny Pack Banner
              Container(
                height: 180,
                margin: const EdgeInsets.symmetric(vertical: 24.0),
                decoration: BoxDecoration(
                  color: Colors.pink[100],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Fanny Packs?',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      ),
                      const SizedBox(height: 24), // <-- Replace Spacer with SizedBox
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          minimumSize: const Size(100, 36),
                        ),
                        child: const Text('SHOP NOW'),
                      ),
                    ],
                  ),
                ),
              ),
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
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
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
                print('Search query: $value');
              },
            ),
          ),
        ],
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
                    color: Colors.white.withOpacity(0.2), // 20% transparent background for label
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Saking',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
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
    };
  });

  Navigator.of(context).pushWithTransition(
    CategoryScreen(title: categoryName, products: sampleProducts),
  );
}

class LatestDropItem extends StatelessWidget {
  const LatestDropItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'latest-drop',
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
          child: const Center(
            child: Text(
              '[Product Image]',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}

