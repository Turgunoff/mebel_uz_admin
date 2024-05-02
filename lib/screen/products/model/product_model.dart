class ProductModel {
  String id;
  String name;
  String category;
  String imageUrl;
  int price;
  int stockQuantity;
  bool isActive;
  String? description;
  // List<String>? imageUrls; // Rasmlarni URL manzili sifatida saqlash

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.stockQuantity,
    required this.isActive,
    required this.description,
    // required this.imageUrls,
  });

  // Method to deserialize Firestore data into a Product object (optional).
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      imageUrl: json['imageUrl'] as String,
      price: json['price'] as int,
      stockQuantity: json['stockQuantity'] as int,
      isActive: json['isActive'] as bool,
      description: json['description'] as String?,
      // imageUrls: List<String>.from(json['imageUrls'] as List ?? []),
    );
  }
  // Method to serialize a Product object into a Map for Firestore (optional).
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'imageUrl': imageUrl,
        'price': price,
        'stockQuantity': stockQuantity,
        'status': isActive,
        'description': description,
        // 'imageUrls': imageUrls,
      };
}
