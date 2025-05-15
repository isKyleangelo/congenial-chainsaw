import 'package:flutter/material.dart';
import '../routes.dart';
import '../screens/cart/cart_screen.dart';

class HLCKAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final bool showCartIcon;

  const HLCKAppBar({
    super.key,
    this.title = 'HLCK',
    this.showBackButton = false,
    this.showCartIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 9,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/4leafclover.png',
            height: 40,
            width: 45,
          ),
          const SizedBox(width: 0),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontFamily: 'Saking',
              ),
            ),
          ),
        ],
      ),
      centerTitle: true,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            )
          : Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
      actions: [
        if (showCartIcon)
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pushWithTransition(const CartScreen());
            },
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
