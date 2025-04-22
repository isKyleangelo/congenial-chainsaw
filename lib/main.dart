import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/confirm_checkout_screen.dart';
import 'screens/wishlist_screen.dart';
import 'screens/oops_screen.dart';
import 'screens/all_products_screen.dart';
import 'screens/category_screen.dart';
import 'screens/account_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HLCK',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
        fontFamily: 'Inter',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
        ),
      ),
      navigatorKey: NavigationService().navigatorKey,
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        '/cart': (context) => const CartScreen(),
        '/confirm-checkout': (context) => const ConfirmCheckoutScreen(),
        '/checkout': (context) => const CheckoutScreen(),
        '/wishlist': (context) => const WishlistScreen(),
        '/oops': (context) => const OopsScreen(),
        '/all-products': (context) => const AllProductsScreen(),
        '/shop': (context) => const AllProductsScreen(),
        '/account': (context) => const AccountScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
      },
      // For category pages, we'll use onGenerateRoute since they need parameters
      onGenerateRoute: (settings) {
        if (settings.name!.startsWith('/category/')) {
          final categoryName = settings.name!.split('/category/')[1];
          return MaterialPageRoute(
            builder: (context) {
              // Sample products for the category
              final List<Map<String, dynamic>> sampleProducts = [
                {
                  'name': '${categoryName.split(' ')[0]} 1',
                  'price': '₱999',
                  'isStock': true,
                  'isSale': false,
                },
                {
                  'name': '${categoryName.split(' ')[0]} 2',
                  'price': '₱1,299',
                  'isStock': true,
                  'isSale': true,
                },
                {
                  'name': '${categoryName.split(' ')[0]} 3',
                  'price': '₱899',
                  'isStock': false,
                  'isSale': false,
                },
                {
                  'name': '${categoryName.split(' ')[0]} 4',
                  'price': '₱1,499',
                  'isStock': true,
                  'isSale': false,
                },
              ];
              
              return CategoryScreen(
                title: categoryName,
                products: sampleProducts,
              );
            },
          );
        }
        return null;
      },
    );
  }
}
