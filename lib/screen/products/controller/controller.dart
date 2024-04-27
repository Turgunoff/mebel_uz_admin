import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mebel_uz_admin/screen/products/model/product.dart';

class ProductsController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  RxList<ProductModel> products = RxList<ProductModel>([]);
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> refreshData() async {
    await fetchProducts(); // Fetch fresh data
  }

  Future<void> fetchProducts() async {
    isLoading.value = true;
    CollectionReference productsRef = _firestore.collection('Products');

    QuerySnapshot querySnapshot = await productsRef.get();
    List<ProductModel> newList = querySnapshot.docs.map((doc) {
      if (doc.data() is Map<String, dynamic>) {
        return ProductModel.fromJson(doc.data() as Map<String, dynamic>);
      } else {
        // Handle unexpected situations here
        throw Exception('Document data is not a Map');
      }
    }).toList();
    products.value = newList; // Update the observable list
    isLoading.value = false; // Set loading to false when data is fetched
  }
}
