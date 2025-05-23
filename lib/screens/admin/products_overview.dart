import 'package:flutter/material.dart';
import 'add_product.dart';

class ProductsOverview extends StatelessWidget {
  const ProductsOverview({super.key});

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
                'Products Overview',
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  _StatCard(label: 'Total Products', value: '23', icon: Icons.inventory_2),
                  const SizedBox(width: 12),
                  _StatCard(label: 'Out of Stock', value: '2', icon: Icons.warning, iconColor: Colors.red),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _StatCard(label: 'Categories', value: '5', icon: Icons.category),
                  const SizedBox(width: 12),
                  Expanded(child: Container()), // Empty for layout
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF133024),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
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
              _SearchBar(hint: 'Search Product'),
              const SizedBox(height: 8),
              _ProductTable(),
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
  const _StatCard({required this.label, required this.value, required this.icon, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF133024),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor ?? Colors.white, size: 24),
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
            const Spacer(),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
        prefixIcon: const Icon(Icons.search, color: Colors.white54),
        suffixIcon: const Icon(Icons.sort, color: Colors.white54),
      ),
    );
  }
}

class _ProductTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: const [
          _ProductRow(product: 'HLCK2', category: 'Classic', price: '600', sold: '220', stock: '59'),
          _ProductRow(product: 'HLCK1', category: 'Classic', price: '600', sold: '91', stock: '22'),
          _ProductRow(product: 'Graphic Tee 1', category: 'Graphics', price: '899', sold: '175', stock: '40'),
          _ProductRow(product: 'Hayubutaw', category: 'Collab', price: '799', sold: '29', stock: '16'),
          _ProductRow(product: 'Hoodie 3', category: 'Hoodies', price: '1600', sold: '366', stock: '30'),
        ],
      ),
    );
  }
}

class _ProductRow extends StatelessWidget {
  final String product, category, price, sold, stock;
  const _ProductRow({required this.product, required this.category, required this.price, required this.sold, required this.stock});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(product, style: const TextStyle(color: Colors.white))),
          Expanded(child: Text(category, style: const TextStyle(color: Colors.white))),
          Expanded(child: Text(price, style: const TextStyle(color: Colors.white))),
          Expanded(child: Text(sold, style: const TextStyle(color: Colors.white))),
          Expanded(child: Text(stock, style: const TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}