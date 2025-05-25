import 'dart:typed_data';

class Product {
  String? id;
  final String name;
  final String price;
  final String? imageUrl;
  final String description;
  final String category;
  final Uint8List? imageBytes; // for upload only

  Product({
    this.id,
    required this.name,
    required this.price,
    this.imageUrl,
    required this.description,
    required this.category,
    this.imageBytes,
  });

  Map<String, dynamic> toJson() {
    return {
      // 🔴 DO NOT SAVE ID TO FIRESTORE
      'name': name,
      'price': price,
      'imageUrl': imageUrl ?? '',
      'description': description,
      'category': category,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json, {String? id}) {
    return Product(
      id: id,
      name: json['name'] ?? '',
      price: json['price'] is String ? json['price'] : json['price'].toString(),
      imageUrl: json['imageUrl'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
    );
  }
}
