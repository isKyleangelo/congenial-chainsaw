import 'package:flutter/material.dart';
import 'sales_overview.dart';
import 'products_overview.dart';
import 'orders_overview.dart';
import 'users_overview.dart';
import '../auth/login_screen.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181A1B),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo and HLCK admin text
                Column(
                  children: [
                    Image.asset('assets/images/clover.png', height: 80),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'HLCK',
                          style: TextStyle(
                            fontFamily: 'Saking', // Use Saking font
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 38,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 6),
                          child: Text(
                            'admin',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                // Dashboard tiles
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 24,
                  childAspectRatio: 1.2,
                  physics: const NeverScrollableScrollPhysics(),
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
                const Spacer(),
                // Logout Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[700],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    icon: const Icon(Icons.logout),
                    label: const Text('Logout'),
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                        (route) => false,
                      );
                    },
                  ),
                ),
              ],
            ),
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
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 36),
              const SizedBox(height: 10),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}