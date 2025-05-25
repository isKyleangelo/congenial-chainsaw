import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // For formatting date

class UsersOverview extends StatelessWidget {
  const UsersOverview({super.key});

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
                'User Overview',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF133024),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.people, color: Colors.white, size: 24),
                    SizedBox(width: 12),
                    Text('Total Users',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    Spacer(),
                    _UserCount(),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _SearchBar(hint: 'Search Customers'),
              const SizedBox(height: 8),
              const _UserTable(),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserCount extends StatelessWidget {
  const _UserCount();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Text('0',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold));
        }
        final count = snapshot.data!.docs.length;
        return Text('$count',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold));
      },
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
      ),
    );
  }
}

class _UserTable extends StatelessWidget {
  const _UserTable();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
                child: Text('No users found',
                    style: TextStyle(color: Colors.white)));
          }
          final users = snapshot.data!.docs;
          return ListView.separated(
            itemCount: users.length,
            separatorBuilder: (_, __) =>
                const Divider(color: Colors.white24, height: 1),
            itemBuilder: (context, index) {
              final user = users[index].data() as Map<String, dynamic>;
              final createdAt = user['createdAt'] is Timestamp
                  ? DateFormat.yMMMd().format(
                      (user['createdAt'] as Timestamp).toDate(),
                    )
                  : '';
              return _UserRow(
                email: user['email'] ?? 'No Email',
                createdAt: createdAt,
              );
            },
          );
        },
      ),
    );
  }
}

class _UserRow extends StatelessWidget {
  final String email, createdAt;
  const _UserRow({required this.email, required this.createdAt});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Text(email, style: const TextStyle(color: Colors.white))),
          Expanded(
              flex: 2,
              child:
                  Text(createdAt, style: const TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}
