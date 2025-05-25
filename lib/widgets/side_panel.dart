import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../routes.dart';
import '../screens/profile_screen.dart';
import '../services/auth_service.dart';
import '../screens/admin/admin_dashboard.dart'; // Add this import

class SidePanel extends StatelessWidget {
  final VoidCallback onClose;

  const SidePanel({
    super.key,
    required this.onClose,
  });

  Future<Map<String, dynamic>?> _getUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      return doc.data();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

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
                child: user?.photoURL != null
                    ? Image.network(
                        user!.photoURL!,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.white,
                      ),
              ),
            ),
            const SizedBox(height: 16),

            // User name and email from Firestore
            FutureBuilder<Map<String, dynamic>?>(
              future: _getUserData(),
              builder: (context, snapshot) {
                final userData = snapshot.data;
                final firstName = userData?['firstName'] ?? '';
                final lastName = userData?['lastName'] ?? '';
                final displayName = '$firstName $lastName'.trim();

                return Column(
                  children: [
                    Text(
                      displayName.isNotEmpty ? 'Hi, $displayName!' : 'Welcome!',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user?.email ?? '',
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                );
              },
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
            // Only show Admin Dashboard if admin: true
            FutureBuilder<Map<String, dynamic>?>(
              future: _getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox.shrink();
                }
                final userData = snapshot.data;
                if (userData != null && userData['isAdmin'] == true) {
                  return _buildNavigationItem(
                    icon: Icons.location_on_outlined,
                    label: 'Admin Dashboard',
                    onTap: () {
                      onClose();
                      Navigator.of(context)
                          .pushWithTransition(const AdminDashboard());
                    },
                  );
                }
                return const SizedBox.shrink();
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
                onPressed: () => AuthService.logout(context),
                icon: const Icon(
                  Icons.logout_outlined,
                  color: Colors.white70,
                ),
                label: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  minimumSize: const Size.fromHeight(48),
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
