import 'package:flutter/material.dart';

class OrdersOverview extends StatelessWidget {
  const OrdersOverview({super.key});

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
                'Orders Overview',
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  _StatCard(label: 'Total Orders', value: '3', icon: Icons.list_alt),
                  const SizedBox(width: 12),
                  _StatCard(label: 'Delivered Orders', value: '3', icon: Icons.check_circle, iconColor: Colors.green),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _StatCard(label: 'Pending Orders', value: '5', icon: Icons.timelapse),
                  const SizedBox(width: 12),
                  _StatCard(label: 'Cancelled Orders', value: '2', icon: Icons.cancel, iconColor: Colors.red),
                ],
              ),
              const SizedBox(height: 16),
              _SearchBar(hint: 'Search Orders'),
              const SizedBox(height: 8),
              _OrderTable(),
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

class _OrderTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: const [
          _OrderRow(orderId: 'OD0001', customerId: 'C0001', amount: '4000', date: '5/9/25', status: 'Delivered'),
          _OrderRow(orderId: 'OD0002', customerId: 'C0001', amount: '1200', date: '4/23/25', status: 'Pending'),
          _OrderRow(orderId: 'OD0003', customerId: 'C0002', amount: '800', date: '2/4/25', status: 'Cancelled'),
        ],
      ),
    );
  }
}

class _OrderRow extends StatelessWidget {
  final String orderId, customerId, amount, date, status;
  const _OrderRow({required this.orderId, required this.customerId, required this.amount, required this.date, required this.status});

  @override
  Widget build(BuildContext context) {
    IconData statusIcon;
    Color statusColor;
    switch (status) {
      case 'Delivered':
        statusIcon = Icons.check_circle;
        statusColor = Colors.green;
        break;
      case 'Pending':
        statusIcon = Icons.timelapse;
        statusColor = Colors.yellow;
        break;
      case 'Cancelled':
        statusIcon = Icons.cancel;
        statusColor = Colors.red;
        break;
      default:
        statusIcon = Icons.help;
        statusColor = Colors.grey;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(orderId, style: const TextStyle(color: Colors.white))),
          Expanded(child: Text(customerId, style: const TextStyle(color: Colors.white))),
          Expanded(child: Text(amount, style: const TextStyle(color: Colors.white))),
          Expanded(child: Text(date, style: const TextStyle(color: Colors.white))),
          Expanded(
            child: Row(
              children: [
                Icon(statusIcon, color: statusColor, size: 18),
                const SizedBox(width: 4),
                Text(status, style: TextStyle(color: statusColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}