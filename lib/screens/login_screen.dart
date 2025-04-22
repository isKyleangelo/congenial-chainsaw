import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import '../routes.dart';
import 'home.dart';
import 'all_products_screen.dart';
import 'wishlist_screen.dart';
import 'account_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              
              // Logo and subtitle
              Center(
                child: Column(
                  children: [
                    const Text(
                      'HLCK',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle, size: 14, color: Colors.green.shade400),
                        const SizedBox(width: 4),
                        Text(
                          'Your Data is Protected',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.green.shade400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Login / Register tab
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushWithTransition(
                          const RegisterScreen(),
                        );
                      },
                      child: const Text(
                        'CREATE AN ACCOUNT',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Email field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Email',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Password field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Password',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              // Password requirements
              Text(
                'Password must be 8-20 letters and contain both letters and numbers. The following symbols can be used: !#\$%()+-./=?@[]^_{|}~',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Show password checkbox
              Row(
                children: [
                  Checkbox(
                    value: !_obscurePassword,
                    onChanged: (value) {
                      setState(() {
                        _obscurePassword = !value!;
                      });
                    },
                    activeColor: Colors.grey,
                    checkColor: Colors.white,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                  const Text(
                    'Show my password',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Continue button
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementWithTransition(
                    const HomePage(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('CONTINUE'),
              ),
              
              const SizedBox(height: 16),
              
              // Forgot password
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot your password?',
                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // OR divider
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'or',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Google login
              OutlinedButton.icon(
                onPressed: () {},
                icon: Image.asset('assets/images/google.png', height: 18, width: 18, errorBuilder: (context, error, stackTrace) => const Icon(Icons.g_mobiledata, size: 18)),
                label: const Text(
                  'Continue with Google',
                  style: TextStyle(color: Colors.black),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Facebook login
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.facebook, color: Colors.blue, size: 18),
                label: const Text(
                  'Continue with Facebook',
                  style: TextStyle(color: Colors.black),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Don't have an account
              Center(
                child: Text(
                  'Don\'t have an account?',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Create account button
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushWithTransition(
                    const RegisterScreen(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('CREATE AN ACCOUNT'),
              ),
              
              const SizedBox(height: 20),
              
              // Terms and privacy policy
              Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Text(
                      'By continuing, you agree to our ',
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Privacy & Cookie Policy',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    Text(
                      ' and ',
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Terms & Conditions',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3, // Account tab
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.of(context).pushReplacementWithTransition(
                const HomePage()
              );
              break;
            case 1:
              Navigator.of(context).pushReplacementWithTransition(
                const AllProductsScreen()
              );
              break;
            case 2:
              Navigator.of(context).pushReplacementWithTransition(
                const WishlistScreen()
              );
              break;
            case 3:
              // Already on account page
              break;
          }
        },
      ),
    );
  }
} 