class Product {
  final String productId;
  final String name;
  final String category;
  final String imageUrl;
  final int price;
  final int stockQuantity;
  final String status;

  Product({
    required this.productId,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.stockQuantity,
    required this.status,
  });

  // Method to deserialize Firestore data into a Product object (optional).
  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json['productId'] as String,
        name: json['name'] as String,
        category: json['category'] as String,
        imageUrl: json['imageUrl'] as String,
        price: json['price'] as int,
        stockQuantity: json['stockQuantity'] as int,
        status: json['status'] as String,
      );

  // Method to serialize a Product object into a Map for Firestore (optional).
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['productId'] = productId;
    data['name'] = name;
    data['category'] = category;
    data['imageUrl'] = imageUrl;
    data['price'] = price;
    data['stockQuantity'] = stockQuantity;
    data['status'] = status;
    return data;
  }
}
