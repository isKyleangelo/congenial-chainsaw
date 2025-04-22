import 'package:flutter/material.dart';

enum NavScreen {
  home,
  shop,
  wishlist,
  account,
  cart,
  checkout,
  oops,
  allProducts,
  plainTee,
  hoodies,
  graphicTee,
  onlyInHlck
}

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  
  factory NavigationService() {
    return _instance;
  }
  
  NavigationService._internal();
  
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
  Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }
  
  void goBack() {
    return navigatorKey.currentState!.pop();
  }
  
  // Custom page route with slide transition
  static Route createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
} 