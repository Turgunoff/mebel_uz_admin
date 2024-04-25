import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mebel_uz_admin/screen/products/controller/controller.dart';
import 'package:mebel_uz_admin/screen/products/model/product.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.fetchProducts();
      },
      child: Scaffold(
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ProductsTable(controller: controller);
          }
        }),
      ),
    );
  }
}

class ProductDataSource extends DataGridSource {
  final List<Product> products;

  ProductDataSource({required this.products}) {
    _productData = products.map<DataGridRow>((product) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'productId', value: product.productId),
        DataGridCell<Widget>(
            columnName: 'image', value: Image.network(product.imageUrl)),
        DataGridCell<String>(columnName: 'name', value: product.name),
        DataGridCell<String>(columnName: 'category', value: product.category),
        DataGridCell<int>(columnName: 'price', value: product.price),
        DataGridCell<int>(
            columnName: 'stockQuantity', value: product.stockQuantity),
        DataGridCell<String>(columnName: 'status', value: product.status),
        DataGridCell<Widget>(
          columnName: 'actions',
          value: Row(children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.edit)), // Edit button
            IconButton(
                onPressed: () {}, icon: Icon(Icons.delete)), // Delete button
          ]),
        ),
      ]);
    }).toList();
  }

  List<DataGridRow> _productData = [];

  @override
  List<DataGridRow> get rows => _productData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((e) {
        return Container(
          alignment:
              ['productId', 'price', 'stockQuantity'].contains(e.columnName)
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(e.value.toString()),
        );
      }).toList(),
    );
  }
}

class ProductsTable extends StatelessWidget {
  final ProductController controller;

  const ProductsTable({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      source: ProductDataSource(products: controller.products),
      allowSorting: true, // Enable sorting on all columns
      columnWidthMode: ColumnWidthMode.auto, // Adjust column widths
      columns: <GridColumn>[
        GridColumn(columnName: 'productId', label: const Text('Mahsulot ID')),
        GridColumn(columnName: 'name', label: const Text('Nomi')),
        GridColumn(columnName: 'price', label: const Text('Narxi')),
        GridColumn(columnName: 'stockQuantity', label: const Text('Ombor')),
        GridColumn(columnName: 'category', label: const Text('Category')),
        GridColumn(columnName: 'status', label: const Text('Status')),
        GridColumn(columnName: 'actions', label: const Text('Actions')),
        GridColumn(columnName: 'image', label: const Text('Rasm')),
        // ... Add more columns as needed
      ],
    );
  }
}
