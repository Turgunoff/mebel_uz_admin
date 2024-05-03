class ProductModel {
  String categoryId;
  String name;
  String categoryName;
  double price;
  int stockQuantity;
  bool isActive = true;
  String? description;
  List<String>? imageUrls; // Rasmlarni URL manzili sifatida saqlash

  ProductModel({
    required this.categoryName,
    required this.name,
    required this.categoryId,
    required this.price,
    required this.stockQuantity,
    required this.isActive,
    required this.description,
    required this.imageUrls,
  });

  // Method to deserialize Firestore data into a Product object (optional).
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      categoryId: json['categoryId'] as String,
      name: json['name'] as String,
      categoryName: json['categoryName'] as String,
      price: json['price'] as double,
      stockQuantity: json['stockQuantity'] as int,
      isActive: json['isActive'] as bool,
      description: json['description'] as String?,
      imageUrls: List<String>.from(json['imageUrls'] as List? ?? []),
    );
  }
  // Method to serialize a Product object into a Map for Firestore (optional).
  Map<String, dynamic> toJson() => {
        'categoryId': categoryId,
        'name': name,
        'categoryName': categoryName,
        'price': price,
        'stockQuantity': stockQuantity,
        'status': isActive,
        'description': description,
        'imageUrls': imageUrls,
      };
}
