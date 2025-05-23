import 'package:flutter/material.dart';

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
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
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
                    Text('Total Users', style: TextStyle(color: Colors.white, fontSize: 16)),
                    Spacer(),
                    Text('3', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _SearchBar(hint: 'Search Customers'),
              const SizedBox(height: 8),
              _UserTable(),
            ],
          ),
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
      ),
    );
  }
}

class _UserTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: const [
          _UserRow(id: 'C0001', username: 'carlxu', email: 'carlgxxl98@gmail.com', orders: '3'),
          _UserRow(id: 'C0002', username: 'bantay755', email: 'bttbts98@gmail.com', orders: '2'),
          _UserRow(id: 'C0003', username: 'lebron_james23', email: 'lebron.unathletic@gmail.com', orders: '1'),
        ],
      ),
    );
  }
}

class _UserRow extends StatelessWidget {
  final String id, username, email, orders;
  const _UserRow({required this.id, required this.username, required this.email, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(id, style: const TextStyle(color: Colors.white))),
          Expanded(child: Text(username, style: const TextStyle(color: Colors.white))),
          Expanded(child: Text(email, style: const TextStyle(color: Colors.white))),
          Expanded(child: Text(orders, style: const TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}