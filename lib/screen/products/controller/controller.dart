import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mebel_uz_admin/screen/products/model/product.dart';

class ProductController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  RxList<Product> products = RxList<Product>([]);
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts(); // Fetch data on initialization
  }

  Future<void> fetchProducts() async {
    isLoading.value = true; // Set loading before making network request
    CollectionReference productsRef = _firestore.collection('Products');

    QuerySnapshot querySnapshot = await productsRef.get();
    products.value = querySnapshot.docs.map((doc) {
      return Product.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();

    isLoading.value = false; // Set loading to false when data arrives
  }

  // Example functions for Add, Edit, Delete (not fully implemented)

  Future<void> addProduct(Product product) async {
    // Add product to Firestore here
  }

  Future<void> updateProduct(Product product) async {
    // Update product in Firestore here
  }

  Future<void> deleteProduct(Product product) async {
    // Delete product from Firestore here
  }
}
