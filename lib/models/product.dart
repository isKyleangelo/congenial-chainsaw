import 'dart:typed_data';

class Product {
  String? id;
  final String name;
  final String price;
  String? imageUrl;
  final String description;
  final String category;
  final Uint8List? imageBytes;

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
      'id': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'description': description,
      'category': category,
    };
  }
}

void main() {
  var product = Product(
    name: 'Tee',
    price: '100',
    imageUrl: 'some_url',
    description: 'desc',
    category: 'plain',
  );

  print(product.toJson());
}
