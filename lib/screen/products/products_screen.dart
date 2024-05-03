import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mebel_uz_admin/screen/products/add_product.dart';

import 'controller/controller.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final controller = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mahsulotlar'),
        actions: [
          Obx(
            () => IconButton(
              onPressed: controller.isLoading.value
                  ? null // Yuklash paytida uni xandaq qilish
                  : () => controller.refreshData(),
              icon: controller.isLoading.value
                  ? const SizedBox(
                      // Yuklash paytida aylantiruvchi indikator
                      height: 18.0,
                      width: 18.0,
                      child: CircularProgressIndicator(),
                    )
                  : const Icon(Icons.refresh),
            ),
          )
        ],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(
                        Colors.grey.shade200), // Sarlavha rangi
                    dataRowColor: MaterialStateProperty.all(Colors.white),
                    border: TableBorder.all(color: Colors.grey.shade300),
                    columns: const [
                      DataColumn(label: Text('№')),
                      DataColumn(label: Text('Rasmi')),
                      DataColumn(label: Text('Nomi')),
                      DataColumn(label: Text('Kategoriya')),
                      DataColumn(label: Text('Narxi')),
                      DataColumn(label: Text('Sotilgan Mahsulotlar')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('Amallar')),
                    ],
                    rows: controller.products.asMap().entries.map((entry) {
                      final index = entry.key +
                          1; // 1-chi raqamdan boshlash uchun +1 qo'shamiz
                      final product = entry.value;
                      return DataRow(
                        cells: [
                          DataCell(Text(index.toString(),
                              textAlign: TextAlign.left)),
                          DataCell(
                            Container(
                              width: 100,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2), // Rasmning kengligini belgilash
                              child: Image.network(
                                product.imageUrls![0],
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          DataCell(
                              Text(product.name, textAlign: TextAlign.left)),
                          DataCell(Text(product.categoryName,
                              textAlign: TextAlign.left)),
                          DataCell(Text(product.price.toString(),
                              textAlign: TextAlign.left)),
                          DataCell(Text(product.stockQuantity.toString(),
                              textAlign: TextAlign.center)),
                          DataCell(Text(
                            product.isActive ? 'Faol' : 'Faol emas',
                            textAlign: TextAlign.center,
                          )),
                          DataCell(Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  // Tahrirlash funktsiyasini amalga oshiring
                                },
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () {
                                  // O'chirish funktsiyasini amalga oshiring
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          )),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddProduct());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
