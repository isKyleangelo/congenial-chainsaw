import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  final CollectionReference _firestoreRef =
      FirebaseFirestore.instance.collection('products');
  final Reference _storageRef = FirebaseStorage.instance.ref('products/');

  final List<Product> _products = [];
  List<Product> get products => _products;

  Future<void> addProduct(Product product) async {
    try {
      String? uploadedImageUrl;

      // 1. Upload image to Cloud Storage if imageBytes exist
      if (product.imageBytes != null &&
          product.imageBytes!.isNotEmpty &&
          product.imageUrl != null &&
          product.imageUrl!.isNotEmpty) {
        final fileName =
            '${DateTime.now().millisecondsSinceEpoch}_${product.imageUrl}';
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

      // 3. Save product to Firestore
      final docRef = await _firestoreRef.add({
        ...productToSave.toJson(),
        'createdAt': FieldValue.serverTimestamp(), // ✅ ADD THIS
      });

      // Optionally set the product's id
      productToSave.id = docRef.id;

      // 4. Fetch products again to update the UI
      await fetchProducts();
    } catch (e) {
      debugPrint('Error adding product: $e');
    }
  }

  Future<void> fetchProducts() async {
    try {
      final snapshot = await _firestoreRef.get();
      final List<Product> loadedProducts = [];
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        loadedProducts.add(
          Product(
            id: doc.id,
            name: data['name'] ?? '',
            price: (data['price'] is String)
                ? data['price']
                : data['price'].toString(),
            imageUrl: data['imageUrl'] ?? '',
            description: data['description'] ?? '',
            category: data['category'] ?? '',
          ),
        );
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
