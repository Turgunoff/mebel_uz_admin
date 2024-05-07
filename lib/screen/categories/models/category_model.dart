class CategoryModel {
  String categoryId;
  String categoryNameUz;
  String categoryNameRu;
  String categoryImage;
  bool isVisibility;

  CategoryModel({
    required this.categoryId,
    required this.categoryNameUz,
    required this.categoryNameRu,
    required this.categoryImage,
    required this.isVisibility,
  });

  // Convert Firestore document snapshot to a CategoryModel
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['categoryId'] as String,
      categoryNameUz: json['categoryNameUz'] as String,
      categoryNameRu: json['categoryNameRu'] as String,
      categoryImage: json['categoryImage'] as String,
      isVisibility: json['isVisibility'] as bool,
    );
  }

  // Convert CategoryModel object to a Map for Firestore
  Map<String, dynamic> toJson() => {
        'categoryId': categoryId,
        'categoryNameUz': categoryNameUz,
        'categoryNameRu': categoryNameRu,
        'categoryImage': categoryImage,
        'isVisibility': isVisibility,
      };
}
