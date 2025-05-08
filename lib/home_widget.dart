import 'package:flutter/material.dart';
import 'widgets/bottom_nav_bar.dart';
import 'widgets/hlck_app_bar.dart';
import 'widgets/common_drawer.dart';
import 'screens/category_screen.dart';
import 'screens/all_products_screen.dart';
import 'screens/wishlist_screen.dart';
import 'screens/account_screen.dart';
import 'routes.dart';

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
              // Search bar
              Container(
                margin: const EdgeInsets.only(top: 16.0, bottom: 16.0),
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
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(
                              bottom: 6.8), // Adjust elevation
                        ),
                        onChanged: (value) {
                          // Handle search input changes here
                          print('Search query: $value');
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Featured image
              Container(
                height: 240,
                margin: const EdgeInsets.only(bottom: 16.0),
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

              // Category grid (2x2)
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  GestureDetector(
                    onTap: () => _navigateToCategory(context, 'Plain Tee'),
                    child: const CategoryItem(title: 'Plain Tee'),
                  ),
                  GestureDetector(
                    onTap: () => _navigateToCategory(context, 'Hoodies'),
                    child: const CategoryItem(title: 'Hoodies'),
                  ),
                  GestureDetector(
                    onTap: () => _navigateToCategory(context, 'Graphic Tee'),
                    child: const CategoryItem(title: 'Graphic Tee'),
                  ),
                  GestureDetector(
                    onTap: () => _navigateToCategory(context, 'Only in HLCK'),
                    child: const CategoryItem(title: 'Only in\nHLCK'),
                  ),
                ],
              ),

              // Latest Drops section
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
                        Navigator.of(context)
                            .pushWithTransition(const AllProductsScreen());
                      },
                      child: const Text(
                        'Shop All',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Latest drops grid (2 items)
              GridView.count(
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

              // Fanny Pack banner
              Container(
                height: 180,
                margin: const EdgeInsets.symmetric(vertical: 24.0),
                decoration: BoxDecoration(
                  color: Colors.pink[100],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
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
                            const SizedBox(height: 80),
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0, // Home tab
        onTap: (index) {
          switch (index) {
            case 0:
              // Already in home
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

  void _navigateToCategory(BuildContext context, String categoryName) {
    // Sample products for demonstration
    final List<Map<String, dynamic>> sampleProducts = [
      {
        'name': '${categoryName.split(' ')[0]} 1',
        'price': '₱999',
        'isStock': true,
        'isSale': false,
      },
      {
        'name': '${categoryName.split(' ')[0]} 2',
        'price': '₱1,299',
        'isStock': true,
        'isSale': true,
      },
      {
        'name': '${categoryName.split(' ')[0]} 3',
        'price': '₱899',
        'isStock': false,
        'isSale': false,
      },
      {
        'name': '${categoryName.split(' ')[0]} 4',
        'price': '₱1,499',
        'isStock': true,
        'isSale': false,
      },
    ];

    Navigator.of(context).pushWithTransition(
      CategoryScreen(
        title: categoryName,
        products: sampleProducts,
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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stack(
            children: [
              // Image or background
              if (title == 'Only in\nHLCK')
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.asset(
                        'images/onlyin_hlck/white_logo1.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.shopping_bag,
                            color: Colors.white,
                            size: 40,
                          );
                        },
                      ),
                    ),
                  ),
                )
              else
                Container(
                  color: Colors.transparent,
                ),
              // Text overlay at bottom
              Positioned(
                bottom: 8,
                left: 8,
                child: Text(
                  title,
                  style: TextStyle(
                    color:
                        title == 'Only in\nHLCK' ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class LatestDropItem extends StatelessWidget {
  const LatestDropItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushWithTransition(const AllProductsScreen());
      },
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
    );
  }
}
