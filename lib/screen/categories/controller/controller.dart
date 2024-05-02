import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/category_model.dart';

class CategoryController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  RxList<CategoryModel> categories = RxList<CategoryModel>([]);
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> refreshData() async {
    await fetchCategories(); // Fetch fresh data
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

  Future<void> addCategory(String categoryName, String categoryImage) async {
    CategoryModel newCategory = CategoryModel(
      categoryId: '', // Let Firestore generate ID
      categoryName: categoryName,
      categoryImage: categoryImage,
    );

    DocumentReference docRef =
        await _firestore.collection('Categories').add(newCategory.toJson());

    // Update the category's categoryId with the documentId
    newCategory.categoryId = docRef.id;

    // Update the categoryId in Firestore
    await docRef.update({'categoryId': docRef.id});

    categories.value = [
      ...categories,
      newCategory
    ]; // Update the controller's list
  }

  Future<void> deleteCategory(CategoryModel category) async {
    try {
      CollectionReference categoriesRef = _firestore.collection('Categories');
      await categoriesRef
          .doc(category.categoryId)
          .delete(); // Delete using documentId

      // Remove the deleted category from the controller's list
      categories
          .removeWhere((element) => element.categoryId == category.categoryId);
    } catch (e) {
      print('Kategoriyani o\'chirishda xatolik yuz berdi: $e');
      // Consider displaying a snackbar or dialog to the user for error handling
    }
  }
}
