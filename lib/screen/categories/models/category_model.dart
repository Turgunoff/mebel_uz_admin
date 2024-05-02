import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String categoryId;
  String categoryName;
  String categoryImage;

  CategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImage,
  });

  // Convert Firestore document snapshot to a CategoryModel
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['categoryId'] as String,
      categoryName: json['categoryName'] as String,
      categoryImage: json['categoryImage'] as String,
    );
  }

  // Convert CategoryModel object to a Map for Firestore
  Map<String, dynamic> toJson() => {
        'categoryId': categoryId,
        'categoryName': categoryName,
        'categoryImage': categoryImage,
      };
}
