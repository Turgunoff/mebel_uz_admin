import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/category_model.dart';

class CategoryController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  RxList<CategoryModel> categories = RxList<CategoryModel>([]);
  RxBool isLoading = true.obs;

  final FirebaseStorage storage = FirebaseStorage.instance;
  final RxList<String> _imageUrls = RxList<String>([]);
  List<String> get imageUrls => _imageUrls;
  String? selectedImage;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  @override
  void onReady() {
    super.onReady();
    fetchImageRefs();
  }

  Future<void> fetchImageRefs() async {
    try {
      final listResult = await storage.ref('categoryIcons').listAll();
      final urls = await Future.wait(
          listResult.items.map((ref) => ref.getDownloadURL()));
      _imageUrls.value = urls; // Yangilash
    } catch (e) {
      print('Error fetching image refs: $e');
    }
  }

  Future<void> refreshData() async {
    await fetchCategories(); // Fetch fresh data
  }

  Future<void> updateCategoryVisibility(CategoryModel category) async {
    try {
      await _firestore
          .collection('Categories')
          .doc(category.categoryId)
          .update({'isVisibility': category.isVisibility});
    } catch (e) {
      print('Error updating category visibility: $e');
    }
  }

  Future<void> fetchCategories() async {
    isLoading.value = true;
    CollectionReference categoriesRef = _firestore.collection('Categories');

    QuerySnapshot querySnapshot = await categoriesRef.get();
    List<CategoryModel> newList = querySnapshot.docs.map((doc) {
      if (doc.data() is Map<String, dynamic>) {
        return CategoryModel.fromJson(doc.data() as Map<String, dynamic>);
      } else {
        // Handle unexpected situations here
        throw Exception('Document data is not a Map');
      }
    }).toList();
    categories.value = newList; // Update the observable list
    isLoading.value = false; // Set loading to false when data is fetched
  }

  Future<void> addCategory(String categoryNameUz, String categoryNameRu,
      String categoryImage) async {
    CategoryModel newCategory = CategoryModel(
      categoryId: '', // Let Firestore generate ID
      categoryNameUz: categoryNameUz,
      categoryNameRu: categoryNameRu,
      categoryImage: categoryImage,
      isVisibility: true,
    );

    DocumentReference docRef =
        await _firestore.collection('Categories').add(newCategory.toJson());

    // Update the category's categoryId with the documentId
    newCategory.categoryId = docRef.id;
    newCategory.categoryImage = selectedImage!;

    // Update the categoryId in Firestore
    await docRef.update({'categoryId': docRef.id});

    categories.value = [
      ...categories,
      newCategory
    ]; // Update the controller's list
  }

  Future<void> deleteCategory(CategoryModel category) async {
    bool? result = await Get.defaultDialog(
      title: 'Chiqish',
      middleText: 'Siz rostdan ham chiqmoqchimisiz?',
      textConfirm: 'Ha',
      backgroundColor: Colors.white,
      textCancel: 'Yo\'q',
      confirmTextColor: Colors.white,
      onConfirm: () => Get.back(result: true),
      onCancel: () => Get.back(result: false),
    );

    if (result != null && result) {
      isLoading.value = true;
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      try {
        CollectionReference categoriesRef = _firestore.collection('Categories');
        await categoriesRef
            .doc(category.categoryId)
            .delete(); // Delete using documentId

        // Remove the deleted category from the controller's list
        categories.removeWhere(
            (element) => element.categoryId == category.categoryId);
      } catch (e) {
        print('Kategoriyani o\'chirishda xatolik yuz berdi: $e');
      } finally {
        isLoading.value = false;
        if (Get.isDialogOpen!) {
          Get.back();
        }
      }
    }
  }
}
