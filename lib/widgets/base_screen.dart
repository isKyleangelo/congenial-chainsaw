import 'package:flutter/material.dart';
import 'bottom_nav_bar.dart';
import 'hlck_app_bar.dart';
import 'common_drawer.dart';

class BaseScreen extends StatelessWidget {
  final String title;
  final bool showBackButton;
  final bool showCartIcon;
  final Widget body;
  final int currentNavIndex;
  final Function(int) onNavTap;
  
  const BaseScreen({
    super.key,
    this.title = 'HLCK',
    this.showBackButton = false,
    this.showCartIcon = true,
    required this.body,
    required this.currentNavIndex,
    required this.onNavTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HLCKAppBar(
        title: title,
        showBackButton: showBackButton,
        showCartIcon: showCartIcon,
      ),
      drawer: const CommonDrawer(),
      body: body,
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentNavIndex,
        onTap: onNavTap,
      ),
    );
  }
} 