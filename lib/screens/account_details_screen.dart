import 'package:flutter/material.dart';
import '../widgets/hlck_app_bar.dart';
import '../widgets/common_drawer.dart';
import '../widgets/bottom_nav_bar.dart';
import '../routes.dart';
import 'home/home.dart';
import 'products/all_products_screen.dart';
import 'wishlist/wishlist_screen.dart';
import 'profile/account_screen.dart';

class AccountDetailsScreen extends StatelessWidget {
  const AccountDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const HLCKAppBar(
        title: 'Account details',
        showBackButton: true,
      ),
      drawer: const CommonDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),

              // Settings header
              const Text(
                'Settings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              // Subheader text
              const Text(
                'You can manage your account and address here.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              // Personal Details section
              _buildSectionHeader('Personal Details', onEditPressed: () {}),
              const SizedBox(height: 16),

              _buildInfoRow('Email', 'kylekuzma85@gmail.com'),
              const SizedBox(height: 12),

              _buildInfoRow('First Name', 'Kyle Angelo'),
              const SizedBox(height: 12),

              _buildInfoRow('Last Name', 'Kuzma'),
              const SizedBox(height: 12),

              _buildInfoRow('Date of Birth', '2004/09/17'),
              const SizedBox(height: 12),

              _buildInfoRow('Gender', 'Male'),
              const SizedBox(height: 12),

              _buildInfoRow('Market', 'Philippines'),

              const SizedBox(height: 30),

              // My Addresses section
              _buildSectionHeader('My Addresses', onEditPressed: () {}),
              const SizedBox(height: 16),

              const Text(
                'You can add and edit delivery addresses here',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 12),

              // Billing address
              _buildInfoRow('Billing address', ''),

              const SizedBox(height: 30),

              // Privacy section
              const Text(
                'Privacy',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              // Change Password button
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                ),
                child: const Text(
                  'Change Password',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3, // Account tab
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.of(context)
                  .pushReplacementWithTransition(const HomePage());
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

  Widget _buildSectionHeader(String title,
      {required VoidCallback onEditPressed}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: onEditPressed,
          child: const Text(
            'Edit',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
