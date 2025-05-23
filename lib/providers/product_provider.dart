import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref('products');
  final Reference _storageRef = FirebaseStorage.instance.ref('product_images');

  final List<Product> _products = [];
  List<Product> get products => _products;

  Future<void> addProduct(Product product) async {
    try {
      String? uploadedImageUrl;

      // 1. Upload image to Cloud Storage if imageBytes exist
      if (product.imageBytes != null && product.imageBytes!.isNotEmpty && product.imageUrl != null && product.imageUrl!.isNotEmpty) {
        final fileName = '${DateTime.now().millisecondsSinceEpoch}_${product.imageUrl}';
        final imageRef = _storageRef.child(fileName);

        UploadTask uploadTask = imageRef.putData(
          product.imageBytes!,
          SettableMetadata(contentType: 'image/png'),
        );

        TaskSnapshot snapshot = await uploadTask;
        uploadedImageUrl = await snapshot.ref.getDownloadURL();
      }

      // 2. Prepare product data with image URL
      final productToSave = Product(
        name: product.name,
        price: product.price,
        description: product.description,
        category: product.category,
        imageUrl: uploadedImageUrl ?? '',
      );

      // 3. Save product to Realtime Database
      final newProductRef = _databaseRef.push();
      productToSave.id = newProductRef.key;

      await newProductRef.set(productToSave.toJson());

      // 4. Fetch products again to update the UI
      await fetchProducts();
    } catch (e) {
      debugPrint('Error adding product: $e');
    }
  }

  Future<void> fetchProducts() async {
    try {
      final snapshot = await _databaseRef.get();
      final List<Product> loadedProducts = [];
      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          loadedProducts.add(
            Product(
              id: key,
              name: value['name'] ?? '',
              price: value['price'] ?? '',
              imageUrl: value['imageUrl'] ?? '',
              description: value['description'] ?? '',
              category: value['category'] ?? '',
            ),
          );
        });
      }
      _products
        ..clear()
        ..addAll(loadedProducts);
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching products: $e');
    }
  }
}