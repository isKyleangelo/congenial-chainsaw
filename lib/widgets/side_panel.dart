import 'package:flutter/material.dart';
import '../routes.dart';
import '../screens/profile_screen.dart';

class SidePanel extends StatelessWidget {
  final VoidCallback onClose;

  const SidePanel({
    super.key,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      color: Colors.black,
      child: SafeArea(
        child: Column(
          children: [
            // Top row with close button
            Padding(
              padding: const EdgeInsets.only(top: 16, right: 16),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: onClose,
                ),
              ),
            ),

            // Profile picture and info
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.teal,
              child: ClipOval(
                child: Image.network(
                  'https://via.placeholder.com/80', // Placeholder image
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // User name and email
            const Text(
              'Hi, Kyle Kuzma!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'kylekuzma85@gmail.com',
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 40),

            // Navigation links
            _buildNavigationItem(
              icon: Icons.shopping_bag_outlined,
              label: 'My Order',
              onTap: () {
                onClose();
                Navigator.of(context).pushWithTransition(const ProfileScreen());
              },
            ),
            _buildNavigationItem(
              icon: Icons.location_on_outlined,
              label: 'Delivery Address',
              onTap: () {
                onClose();
                // Navigate to address screen
              },
            ),
            _buildNavigationItem(
              icon: Icons.payment_outlined,
              label: 'Payment Method',
              onTap: () {
                onClose();
                // Navigate to payment screen
              },
            ),
            _buildNavigationItem(
              icon: Icons.mail_outline,
              label: 'Contact Us!',
              onTap: () {
                onClose();
                // Navigate to contact screen
              },
            ),
            _buildNavigationItem(
              icon: Icons.help_outline,
              label: 'Help and FAQs',
              onTap: () {
                onClose();
                // Navigate to help screen
              },
            ),

            const Spacer(),

            // Logout button
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextButton.icon(
                onPressed: () {
                  onClose();
                  // Handle logout
                },
                icon: const Icon(
                  Icons.logout_outlined,
                  color: Colors.white70,
                ),
                label: Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
        size: 24,
      ),
      title: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      minLeadingWidth: 20,
    );
  }
}
