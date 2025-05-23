import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _products = [
    Product(
      name: 'HLCK White Logo Shirt',
      price: '₱899',
      imageUrl: 'assets/images/onlyin_hlck/white.png',
      description: 'Stay effortlessly fresh with the HLCK White Tee — the ultimate cotton classic, made for all-day comfort and clean style. Crisp, breathable, and soft, this white essential pairs with everything. Available exclusively at HLCK — your source for standout basics.',
    ),
    Product(
      name: 'HLCK Black Logo Shirt',
      price: '₱899',
      imageUrl: 'assets/images/onlyin_hlck/black.png',
      description: 'Elevate your everyday look with the HLCK Black Tee — sleek, soft cotton designed to keep you cool and confident. This deep black staple is perfect for any occasion. Get it exclusively at HLCK and own your style like no one else.',
    ),
    Product(
      name: 'HLCK Green Logo Shirt',
      price: '₱899',
      imageUrl: 'assets/images/onlyin_hlck/green.png',
      description: 'Bring fresh energy with the HLCK Green Tee. Crafted from comfy cotton and bursting with rich green vibes, it’s the perfect twist to your wardrobe. Exclusively available at HLCK — because unique style deserves a unique home.',
    ),
  ];

  List<Product> get products => List.unmodifiable(_products);

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }
}