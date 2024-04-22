import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/model.dart';

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

  Future<void> addCategory(CategoryModel category) async {
    CollectionReference categoriesRef = _firestore.collection('Categories');
    DocumentReference docRef =
        await categoriesRef.add(category.toJson()); // Use documentId

    // Update the category's documentId after adding
    category.categoryId = docRef.id;
    categories.value = [
      ...categories,
      category
    ]; // Update the controller's list
  }
}
