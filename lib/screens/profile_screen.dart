import 'package:flutter/material.dart';
import '../widgets/hlck_app_bar.dart';
import '../widgets/common_drawer.dart';
import '../routes.dart';
import 'orders_screen.dart';
import 'account_details_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const HLCKAppBar(
        title: 'Profile',
        showBackButton: true,
      ),
      drawer: const CommonDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),

            // Profile Name
            const Center(
              child: Text(
                'KYLE KUZMA',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Main menu options
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCircleMenuButton(
                  context: context,
                  icon: Icons.shopping_bag_outlined,
                  label: 'Orders',
                  onTap: () {
                    Navigator.of(context)
                        .pushWithTransition(const OrdersScreen());
                  },
                ),
                _buildCircleMenuButton(
                  context: context,
                  icon: Icons.settings_outlined,
                  label: 'Settings',
                  onTap: () {
                    Navigator.of(context)
                        .pushWithTransition(const AccountDetailsScreen());
                  },
                ),
              ],
            ),

            const SizedBox(height: 40),

            // More menu options
            _buildMenuOption(
              icon: Icons.list_alt_outlined,
              label: 'My orders',
              onTap: () {
                Navigator.of(context).pushWithTransition(const OrdersScreen());
              },
            ),

            const Divider(height: 1),

            _buildMenuOption(
              icon: Icons.person_outline,
              label: 'Account Details',
              onTap: () {
                Navigator.of(context)
                    .pushWithTransition(const AccountDetailsScreen());
              },
            ),

            const Divider(height: 1),

            _buildMenuOption(
              icon: Icons.support_agent_outlined,
              label: 'Customer Service',
              onTap: () {},
            ),

            const Divider(height: 1),

            _buildMenuOption(
              icon: Icons.logout_outlined,
              label: 'Sign out',
              onTap: () {},
            ),

            const Divider(height: 1),

            _buildMenuOption(
              icon: Icons.feedback_outlined,
              label: 'Help us improve the app',
              onTap: () {},
            ),

            const Spacer(),

            // HLCK logo at bottom
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'HLCK',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      'PH',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleMenuButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: Icon(
              icon,
              size: 28,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, size: 24),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      minLeadingWidth: 20,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      onTap: onTap,
    );
  }
}
