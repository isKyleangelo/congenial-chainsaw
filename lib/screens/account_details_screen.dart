import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/hlck_app_bar.dart';
import '../widgets/common_drawer.dart';
import '../widgets/bottom_nav_bar.dart';
import '../routes.dart';
import 'home/home.dart';
import 'products/all_products_screen.dart';
import 'wishlist/wishlist_screen.dart';
import 'profile/account_screen.dart';

class AccountDetailsScreen extends StatefulWidget {
  const AccountDetailsScreen({super.key});

  @override
  State<AccountDetailsScreen> createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  String email = '';
  String firstName = '';
  String lastName = '';
  String dob = '';
  String gender = '';
  String market = '';
  String address = ''; // <-- Add this
  String billingAddress = ''; // <-- Add this
  List<String> addresses = []; // <-- Add this

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (doc.exists) {
      final data = doc.data()!;
      setState(() {
        email = data['email'] ?? '';
        firstName = data['firstName'] ?? '';
        lastName = data['lastName'] ?? '';
        dob = data['dob'] ?? '';
        gender = data['gender'] ?? '';
        market = data['market'] ?? '';
        addresses = List<String>.from(data['addresses'] ?? []);
        billingAddress = data['billingAddress'] ?? '';
      });
    }
  }

  Future<void> _editProfile() async {
    final firstNameController = TextEditingController(text: firstName);
    final lastNameController = TextEditingController(text: lastName);
    final dobController = TextEditingController(text: dob);
    final genderController = TextEditingController(text: gender);
    final marketController = TextEditingController(text: market);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: firstNameController, decoration: const InputDecoration(labelText: 'First Name')),
              TextField(controller: lastNameController, decoration: const InputDecoration(labelText: 'Last Name')),
              TextField(controller: dobController, decoration: const InputDecoration(labelText: 'Date of Birth')),
              TextField(controller: genderController, decoration: const InputDecoration(labelText: 'Gender')),
              TextField(controller: marketController, decoration: const InputDecoration(labelText: 'Market')),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final uid = FirebaseAuth.instance.currentUser?.uid;
              if (uid != null) {
                await FirebaseFirestore.instance.collection('users').doc(uid).set({
                  'email': email,
                  'firstName': firstNameController.text,
                  'lastName': lastNameController.text,
                  'dob': dobController.text,
                  'gender': genderController.text,
                  'market': marketController.text,
                }, SetOptions(merge: true));
                setState(() {
                  firstName = firstNameController.text;
                  lastName = lastNameController.text;
                  dob = dobController.text;
                  gender = genderController.text;
                  market = marketController.text;
                });
              }
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _editAddresses() async {
    List<TextEditingController> controllers =
        addresses.map((a) => TextEditingController(text: a)).toList();
    final newAddressController = TextEditingController();
    final billingAddressController = TextEditingController(text: billingAddress);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Addresses'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              ...controllers.asMap().entries.map((entry) {
                final idx = entry.key;
                final controller = entry.value;
                return Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(labelText: 'Address ${idx + 1}'),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          addresses.removeAt(idx);
                        });
                        Navigator.pop(context);
                        _editAddresses();
                      },
                    ),
                  ],
                );
              }),
              TextField(
                controller: newAddressController,
                decoration: const InputDecoration(labelText: 'Add new address'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: billingAddressController,
                decoration: const InputDecoration(labelText: 'Billing Address'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final uid = FirebaseAuth.instance.currentUser?.uid;
              if (uid != null) {
                // Update addresses from controllers
                final updatedAddresses = controllers.map((c) => c.text).where((a) => a.isNotEmpty).toList();
                // Add new address if provided
                if (newAddressController.text.trim().isNotEmpty) {
                  updatedAddresses.add(newAddressController.text.trim());
                }
                await FirebaseFirestore.instance.collection('users').doc(uid).set({
                  'addresses': updatedAddresses,
                  'billingAddress': billingAddressController.text,
                }, SetOptions(merge: true));
                setState(() {
                  addresses = updatedAddresses;
                  billingAddress = billingAddressController.text;
                });
              }
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _changePassword() async {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Password'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: currentPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Current Password'),
              ),
              TextField(
                controller: newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'New Password'),
              ),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Confirm New Password'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              final email = user?.email;
              final currentPassword = currentPasswordController.text;
              final newPassword = newPasswordController.text;
              final confirmPassword = confirmPasswordController.text;

              if (newPassword != confirmPassword) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('New passwords do not match')),
                );
                return;
              }
              if (user != null && email != null) {
                try {
                  // Re-authenticate
                  final cred = EmailAuthProvider.credential(email: email, password: currentPassword);
                  await user.reauthenticateWithCredential(cred);
                  // Change password
                  await user.updatePassword(newPassword);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Password changed successfully')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${e.toString()}')),
                  );
                }
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

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
              _buildSectionHeader('Personal Details', onEditPressed: _editProfile),
              const SizedBox(height: 16),

              _buildInfoRow('Email', email),
              const SizedBox(height: 12),

              _buildInfoRow('First Name', firstName),
              const SizedBox(height: 12),

              _buildInfoRow('Last Name', lastName),
              const SizedBox(height: 12),

              _buildInfoRow('Date of Birth', dob),
              const SizedBox(height: 12),

              _buildInfoRow('Gender', gender),
              const SizedBox(height: 12),

              _buildInfoRow('Market', market),

              const SizedBox(height: 30),

              // My Addresses section
              _buildSectionHeader('My Addresses', onEditPressed: _editAddresses), // <-- Use new edit
              const SizedBox(height: 16),
              const Text(
                'You can add and edit delivery addresses here',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < addresses.length; i++)
                    _buildInfoRow('Address ${i + 1}', addresses[i]),
                  if (addresses.isEmpty)
                    const Text('No addresses yet.', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 12),
                  _buildInfoRow('Billing address', billingAddress),
                ],
              ),

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
                onPressed: () {
                  _changePassword();
                },
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
