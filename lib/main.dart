import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'widgets/home_widget.dart';
import 'screens/cart/cart_screen.dart';
import 'screens/confirm_checkout_screen.dart';
import 'screens/confirm_checkout_screen.dart';
import 'screens/wishlist/wishlist_screen.dart';
import 'screens/oops_screen.dart';
import 'screens/products/all_products_screen.dart';
import 'screens/profile/account_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/products/category_screen.dart'; // <-- Make sure this import is correct
import 'navigation.dart';
import 'config/firebase_options.dart';
import 'providers/product_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (Firebase.apps.isEmpty) {
      print('Initializing Firebase...');
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform.copyWith(
          databaseURL: 'https://finalproject-91acc-default-rtdb.firebaseio.com',
        ),
      );
      print('Firebase initialized!');
    } else {
      print('Firebase already initialized.');
    }
  } catch (e) {
    print('Firebase init error: $e');
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: const MyApp(),
    ),
  );
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
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasData) {
            return const HomePage();
          }
          return const LoginScreen();
        },
      ),
      routes: {
        '/home': (context) => const HomePage(),
        '/cart': (context) => const CartScreen(),
        '/confirm-checkout': (context) => const CheckoutScreen(),
        '/checkout': (context) => const CheckoutScreen(),
        '/wishlist': (context) => const WishlistScreen(),
        '/oops': (context) => const OopsScreen(),
        '/all-products': (context) => const AllProductsScreen(),
        '/shop': (context) => const AllProductsScreen(),
        '/account': (context) => const AccountScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name!.startsWith('/category/')) {
          final categoryName = settings.name!.split('/category/')[1];

          return MaterialPageRoute(
            builder: (context) => CategoryScreen(title: categoryName),
          );
        }
        return null;
      },
    );
  }
}

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}
