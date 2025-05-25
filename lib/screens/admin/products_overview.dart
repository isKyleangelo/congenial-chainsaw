import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_product.dart'; // Make sure this file exists with AddProductPage defined

class ProductsOverview extends StatelessWidget {
  const ProductsOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181A1B),
      body: SafeArea(
        child: SingleChildScrollView(
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
                'Products Overview',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              // Stats Row with real Firestore data for total products, etc.
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .snapshots(),
                builder: (context, snapshot) {
                  final totalProducts =
                      snapshot.hasData ? snapshot.data!.docs.length : 0;

                  // You can extend this by calculating out of stock and categories dynamically if needed
                  final outOfStockCount = snapshot.hasData
                      ? snapshot.data!.docs.where((doc) {
                          final data = doc.data() as Map<String, dynamic>;
                          final stock = data['stock'] ?? 0;
                          return stock == 0;
                        }).length
                      : 0;

                  // Dummy categories count for now, or you can extract unique categories from data
                  final categoriesCount = 5;

                  return Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: _StatCard(
                            label: 'Total Products',
                            value: '$totalProducts',
                            icon: Icons.inventory_2),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: _StatCard(
                            label: 'Out of Stock',
                            value: '$outOfStockCount',
                            icon: Icons.warning,
                            iconColor: Colors.red),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: _StatCard(
                            label: 'Categories',
                            value: '$categoriesCount',
                            icon: Icons.category),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 16),

              // --- Add Product Button ---
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF133024),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddProductPage()),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Product'),
              ),

              const SizedBox(height: 16),

              const _SearchBar(hint: 'Search Product'),

              const SizedBox(height: 8),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: const _ProductTable(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label, value;
  final IconData icon;
  final Color? iconColor;
  const _StatCard(
      {required this.label,
      required this.value,
      required this.icon,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF133024),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor ?? Colors.white, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label,
                style: const TextStyle(color: Colors.white, fontSize: 16)),
          ),
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final String hint;
  const _SearchBar({required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: const Color(0xFF222324),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none),
        prefixIcon: const Icon(Icons.search, color: Colors.white54),
        suffixIcon: const Icon(Icons.sort, color: Colors.white54),
      ),
    );
  }
}

class _ProductTable extends StatelessWidget {
  const _ProductTable();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
              child: Text('No products found',
                  style: TextStyle(color: Colors.white)));
        }

        final products = snapshot.data!.docs;

        return ListView.separated(
          itemCount: products.length,
          separatorBuilder: (_, __) => const Divider(color: Colors.white24),
          itemBuilder: (context, index) {
            final data = products[index].data() as Map<String, dynamic>;
            return _ProductRow(
              docId: products[index].id,
              product: data['name'] ?? '',
              category: data['category'] ?? '',
              price: data['price'].toString(),
              sold: data['sold']?.toString() ?? '0',
              stock: data['stock']?.toString() ?? '0',
            );
          },
        );
      },
    );
  }
}

class _ProductRow extends StatelessWidget {
  final String docId, product, category, price, sold, stock;

  const _ProductRow({
    required this.docId,
    required this.product,
    required this.category,
    required this.price,
    required this.sold,
    required this.stock,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
              child:
                  Text(product, style: const TextStyle(color: Colors.white))),
          Expanded(
              child:
                  Text(category, style: const TextStyle(color: Colors.white))),
          Expanded(
              child:
                  Text('₱$price', style: const TextStyle(color: Colors.white))),
          Expanded(
              child: Text(sold, style: const TextStyle(color: Colors.white))),
          Expanded(
              child: Text(stock, style: const TextStyle(color: Colors.white))),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) async {
              if (value == 'restock') {
                final controller = TextEditingController();
                final result = await showDialog<String>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Restock Product"),
                    content: TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: 'New stock quantity'),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel")),
                      TextButton(
                          onPressed: () =>
                              Navigator.pop(context, controller.text),
                          child: const Text("Update")),
                    ],
                  ),
                );
                if (result != null && result.isNotEmpty) {
                  final newStock = int.tryParse(result);
                  if (newStock != null) {
                    await FirebaseFirestore.instance
                        .collection('products')
                        .doc(docId)
                        .update({'stock': newStock});
                  }
                }
              } else if (value == 'delete') {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Product'),
                    content: const Text(
                        'Are you sure you want to delete this product?'),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel')),
                      TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Delete')),
                    ],
                  ),
                );
                if (confirm == true) {
                  await FirebaseFirestore.instance
                      .collection('products')
                      .doc(docId)
                      .delete();
                }
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'restock', child: Text('Restock')),
              const PopupMenuItem(value: 'delete', child: Text('Delete')),
            ],
          ),
        ],
      ),
    );
  }
}
