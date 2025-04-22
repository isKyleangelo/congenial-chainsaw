import 'package:flutter/material.dart';
import 'side_panel.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Stack(
        children: [
          // Transparent overlay for tap to close
          Positioned.fill(
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          
          // Side panel
          Align(
            alignment: Alignment.centerLeft,
            child: SidePanel(
              onClose: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
} 