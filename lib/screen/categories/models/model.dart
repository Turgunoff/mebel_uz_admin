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
  factory CategoryModel.fromJson(json) {
    return CategoryModel(
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      categoryImage: json['categoryImage'],
    );
  }
}
