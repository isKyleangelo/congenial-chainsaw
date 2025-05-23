import 'dart:typed_data';

class Product {
  final String name;
  final String price;
  final String description;
  final String imageUrl;
  final bool isStock;
  final bool isSale;
  final Uint8List? imageBytes;

  Product({
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    this.isStock = true,
    this.isSale = false,
    this.imageBytes,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      price: map['price'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      isStock: map['isStock'] ?? true,
      isSale: map['isSale'] ?? false,
    );
  }
}
