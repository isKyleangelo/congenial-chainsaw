import 'package:flutter/material.dart';
import 'sales_overview.dart';
import 'products_overview.dart';
import 'orders_overview.dart';
import 'users_overview.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181A1B),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset('assets/images/shopnow_shamrock.png', height: 40),
                  const SizedBox(width: 12),
                  const Text(
                    'HLCK',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 48),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  children: [
                    _DashboardTile(
                      icon: Icons.bar_chart,
                      label: 'Sales',
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SalesOverview())),
                    ),
                    _DashboardTile(
                      icon: Icons.inventory_2,
                      label: 'Products',
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductsOverview())),
                    ),
                    _DashboardTile(
                      icon: Icons.receipt_long,
                      label: 'Orders',
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OrdersOverview())),
                    ),
                    _DashboardTile(
                      icon: Icons.people,
                      label: 'Users',
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const UsersOverview())),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashboardTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _DashboardTile({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF133024),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 40),
              const SizedBox(height: 12),
              Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SalesOverview extends StatelessWidget {
  const SalesOverview({super.key});

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
                'Sales Overview',
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  _StatCard(label: 'Total Sales:', value: '—'),
                  const SizedBox(width: 16),
                  _StatCard(label: 'Total Revenue:', value: '—'),
                ],
              ),
              const SizedBox(height: 32),
              const Text(
                'Product         Category     Sold     Date         Price',
                style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
              ),
              const Divider(color: Colors.white24),
              // Example data row
              _SalesRow(product: 'HLCK2', category: 'Classic', sold: '2', date: '4/23/25', price: '1200'),
              _SalesRow(product: 'Spidey Tee', category: 'Collab', sold: '1', date: '3/27/25', price: '1009'),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF133024),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(Icons.monetization_on, color: Colors.white, size: 24),
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

class _SalesRow extends StatelessWidget {
  final String product, category, sold, date, price;
  const _SalesRow({required this.product, required this.category, required this.sold, required this.date, required this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(product, style: const TextStyle(color: Colors.white))),
          Expanded(child: Text(category, style: const TextStyle(color: Colors.white))),
          Expanded(child: Text(sold, style: const TextStyle(color: Colors.white))),
          Expanded(child: Text(date, style: const TextStyle(color: Colors.white))),
          Expanded(child: Text(price, style: const TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}