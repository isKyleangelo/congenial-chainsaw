import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'bottom_nav_bar.dart';
import 'hlck_app_bar.dart';
import 'common_drawer.dart';
import '../screens/products/category_screen.dart';
import '../screens/products/all_products_screen.dart';
import '../screens/wishlist/wishlist_screen.dart';
import '../screens/profile/account_screen.dart';

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
    print('Loading latest products...');

    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('products')
        .orderBy('createdAt', descending: true)
        .limit(2)
        .get();

    print("Fetched ${snapshot.docs.length} products.");

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
              // _buildSearchBar(), // <-- Removed search bar
              const SizedBox(height: 16.0),
              _buildBanner(),
              const SizedBox(height: 16.0),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 0.95,
                children: [
                  CategoryItem(
                      title: 'Plain Tee', onTapCategory: _navigateToCategory),
                  CategoryItem(
                      title: 'Hoodies', onTapCategory: _navigateToCategory),
                  CategoryItem(
                      title: 'Graphic Tee', onTapCategory: _navigateToCategory),
                  CategoryItem(
                      title: 'Only in\nHLCK',
                      onTapCategory: _navigateToCategory),
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

  Widget _buildBanner() {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.width *
          0.6, // Responsive height (60% of screen width)
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'assets/images/S.png',
          fit: BoxFit.cover, // Fill the whole container
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Icon(Icons.broken_image, color: Colors.grey, size: 48),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
        image: DecorationImage(
          image: AssetImage('assets/images/Untitled design.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Optionally, you can add a semi-transparent overlay for better button visibility:
          // Container(
          //   color: Colors.white.withOpacity(0.7),
          // ),
          const SizedBox(height: 80), // Space for the image background
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const AllProductsScreen()),
              );
            },
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
                return LatestDropItem(
                  name: product['name'],
                  price: '₱${product['price']}',
                  imageUrl: product['imageUrl'],
                );
              },
            ),
    );
  }

  /// ✅ UPDATED NAVIGATE FUNCTION
  Future<void> _navigateToCategory(
      BuildContext context, String categoryKey) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CategoryScreen(title: categoryKey),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String title;
  final Future<void> Function(BuildContext, String) onTapCategory;

  const CategoryItem({
    super.key,
    required this.title,
    required this.onTapCategory,
  });

  String get _imagePath {
    if (title == 'Plain Tee') {
      return 'assets/images/plain/plain_olive.png';
    } else if (title == 'Hoodies') {
      return 'assets/images/hoodie/risktaker.png';
    } else if (title == 'Graphic Tee') {
      return 'assets/images/graphic_tee/moneybank.png';
    } else if (title == 'Only in\nHLCK') {
      return 'assets/images/onlyin_hlck/white_logo1.png';
    }
    return '';
  }

  String get _categoryKey {
    if (title == 'Plain Tee') return 'plain';
    if (title == 'Hoodies') return 'hoodies';
    if (title == 'Graphic Tee') return 'graphic tees';
    if (title == 'Only in\nHLCK') return 'OG';
    return title.toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await onTapCategory(context, _categoryKey);
      },
      child: Container(
        width: 160,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
          // Removed borderRadius for sharp corners
        ),
        child: Column(
          children: [
            // Product Image Section
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF0F0F0),
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                ),
                child: _imagePath.isNotEmpty
                    ? Image.asset(
                        _imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildTShirtIcon();
                        },
                      )
                    : _buildTShirtIcon(),
              ),
            ),
            // Product Title Section
            Container(
              width: double.infinity,
              height: 30, // Fixed height for the black label container
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              alignment:
                  Alignment.center, // Ensures text is vertically centered
              child: Text(
                title == 'Only in\nHLCK'
                    ? 'Only in HLCK'
                    : title, // <-- Make label one line
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  fontFamily: 'Poppins', // Use Poppins font
                  letterSpacing: -0.18,
                ),
                textAlign: TextAlign.center,
                maxLines: 1, // <-- Force single line
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTShirtIcon() {
    return Center(
      child: SizedBox(
        width: 80,
        height: 90,
        child: CustomPaint(
          painter: TShirtPainter(),
        ),
      ),
    );
  }
}

class TShirtPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF121212)
      ..style = PaintingStyle.fill;

    final path = Path();

    // T-shirt body
    path.moveTo(size.width * 0.2, size.height * 0.3);
    path.lineTo(size.width * 0.8, size.height * 0.3);
    path.lineTo(size.width * 0.8, size.height * 0.9);
    path.lineTo(size.width * 0.40, size.height * 0.70);
    path.close();

    // Minimalist neck
    path.moveTo(size.width * 0.46, size.height * 0.15);
    path.lineTo(size.width * 0.54, size.height * 0.15);
    path.lineTo(size.width * 0.54, size.height * 0.3);
    path.lineTo(size.width * 0.46, size.height * 0.3);
    path.close();

    // Left sleeve
    path.moveTo(size.width * 0.05, size.height * 0.2);
    path.lineTo(size.width * 0.2, size.height * 0.2);
    path.lineTo(size.width * 0.2, size.height * 0.5);
    path.lineTo(size.width * 0.05, size.height * 0.45);
    path.close();

    // Right sleeve
    path.moveTo(size.width * 0.8, size.height * 0.2);
    path.lineTo(size.width * 0.95, size.height * 0.2);
    path.lineTo(size.width * 0.95, size.height * 0.45);
    path.lineTo(size.width * 0.8, size.height * 0.5);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
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
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
