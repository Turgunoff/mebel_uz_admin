import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/controller.dart';

class ProductsScreen extends StatefulWidget {
  ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final controller = Get.put(ProductsController());

  // Statik ma'lumotlar (masalan, Firestore'dan olingan ma'lumotlarni simulyatsiya qilish uchun)
  final List<Map<String, dynamic>> productsData = [
    {
      "productId": "1",
      "productImage":
          "https://avatars.mds.yandex.net/i?id=4796ab12d7cb5f88c663b50162e0bb585bbe388d-7012253-images-thumbs&n=13",
      "productName": "Mahsulot 1",
      "productCategory": "Kategoriya 1",
      "price": 100.00,
      "soldProducts": 20,
    },
    {
      "productId": "2",
      "productImage":
          "https://avatars.mds.yandex.net/i?id=4796ab12d7cb5f88c663b50162e0bb585bbe388d-7012253-images-thumbs&n=13",
      "productName": "Mahsulot 2",
      "productCategory": "Kategoriya 2",
      "price": 50.00,
      "soldProducts": 15,
    },
    {
      "productId": "1",
      "productImage":
          "https://avatars.mds.yandex.net/i?id=4796ab12d7cb5f88c663b50162e0bb585bbe388d-7012253-images-thumbs&n=13",
      "productName": "Mahsulot 1",
      "productCategory": "Kategoriya 1",
      "price": 100.00,
      "soldProducts": 20,
    },
    {
      "productId": "2",
      "productImage":
          "https://avatars.mds.yandex.net/i?id=4796ab12d7cb5f88c663b50162e0bb585bbe388d-7012253-images-thumbs&n=13",
      "productName": "Mahsulot 2",
      "productCategory": "Kategoriya 2",
      "price": 50.00,
      "soldProducts": 15,
    },
    {
      "productId": "1",
      "productImage":
          "https://avatars.mds.yandex.net/i?id=4796ab12d7cb5f88c663b50162e0bb585bbe388d-7012253-images-thumbs&n=13",
      "productName": "Mahsulot 1",
      "productCategory": "Kategoriya 1",
      "price": 100.00,
      "soldProducts": 20,
    },
    {
      "productId": "2",
      "productImage":
          "https://avatars.mds.yandex.net/i?id=4796ab12d7cb5f88c663b50162e0bb585bbe388d-7012253-images-thumbs&n=13",
      "productName": "Mahsulot 2",
      "productCategory": "Kategoriya 2",
      "price": 50.00,
      "soldProducts": 15,
    },
    {
      "productId": "1",
      "productImage":
          "https://avatars.mds.yandex.net/i?id=4796ab12d7cb5f88c663b50162e0bb585bbe388d-7012253-images-thumbs&n=13",
      "productName": "Mahsulot 1",
      "productCategory": "Kategoriya 1",
      "price": 100.00,
      "soldProducts": 20,
    },
    {
      "productId": "2",
      "productImage":
          "https://avatars.mds.yandex.net/i?id=4796ab12d7cb5f88c663b50162e0bb585bbe388d-7012253-images-thumbs&n=13",
      "productName": "Mahsulot 2",
      "productCategory": "Kategoriya 2",
      "price": 50.00,
      "soldProducts": 15,
    },
    {
      "productId": "1",
      "productImage":
          "https://avatars.mds.yandex.net/i?id=4796ab12d7cb5f88c663b50162e0bb585bbe388d-7012253-images-thumbs&n=13",
      "productName": "Mahsulot 1",
      "productCategory": "Kategoriya 1",
      "price": 100.00,
      "soldProducts": 20,
    },
    {
      "productId": "2",
      "productImage":
          "https://avatars.mds.yandex.net/i?id=4796ab12d7cb5f88c663b50162e0bb585bbe388d-7012253-images-thumbs&n=13",
      "productName": "Mahsulot 2",
      "productCategory": "Kategoriya 2",
      "price": 50.00,
      "soldProducts": 15,
    },
    {
      "productId": "1",
      "productImage":
          "https://avatars.mds.yandex.net/i?id=4796ab12d7cb5f88c663b50162e0bb585bbe388d-7012253-images-thumbs&n=13",
      "productName": "Mahsulot 1",
      "productCategory": "Kategoriya 1",
      "price": 100.00,
      "soldProducts": 20,
    },
    {
      "productId": "2",
      "productImage":
          "https://avatars.mds.yandex.net/i?id=4796ab12d7cb5f88c663b50162e0bb585bbe388d-7012253-images-thumbs&n=13",
      "productName": "Mahsulot 2",
      "productCategory": "Kategoriya 2",
      "price": 50.00,
      "soldProducts": 15,
    },
    {
      "productId": "1",
      "productImage":
          "https://avatars.mds.yandex.net/i?id=4796ab12d7cb5f88c663b50162e0bb585bbe388d-7012253-images-thumbs&n=13",
      "productName": "Mahsulot 1",
      "productCategory": "Kategoriya 1",
      "price": 100.00,
      "soldProducts": 20,
    },
    {
      "productId": "2",
      "productImage":
          "https://avatars.mds.yandex.net/i?id=4796ab12d7cb5f88c663b50162e0bb585bbe388d-7012253-images-thumbs&n=13",
      "productName": "Mahsulot 2",
      "productCategory": "Kategoriya 2",
      "price": 50.00,
      "soldProducts": 15,
    },
    {
      "productId": "1",
      "productImage":
          "https://avatars.mds.yandex.net/i?id=4796ab12d7cb5f88c663b50162e0bb585bbe388d-7012253-images-thumbs&n=13",
      "productName": "Mahsulot 1",
      "productCategory": "Kategoriya 1",
      "price": 100.00,
      "soldProducts": 20,
    },
    {
      "productId": "2",
      "productImage":
          "https://avatars.mds.yandex.net/i?id=4796ab12d7cb5f88c663b50162e0bb585bbe388d-7012253-images-thumbs&n=13",
      "productName": "Mahsulot 2",
      "productCategory": "Kategoriya 2",
      "price": 50.00,
      "soldProducts": 15,
    },
    {
      "productId": "1",
      "productImage":
          "https://avatars.mds.yandex.net/i?id=4796ab12d7cb5f88c663b50162e0bb585bbe388d-7012253-images-thumbs&n=13",
      "productName": "Mahsulot 1",
      "productCategory": "Kategoriya 1",
      "price": 100.00,
      "soldProducts": 20,
    },
    {
      "productId": "2",
      "productImage":
          "https://avatars.mds.yandex.net/i?id=4796ab12d7cb5f88c663b50162e0bb585bbe388d-7012253-images-thumbs&n=13",
      "productName": "Mahsulot 2",
      "productCategory": "Kategoriya 2",
      "price": 50.00,
      "soldProducts": 15,
    },
    {
      "productId": "1",
      "productImage":
          "https://avatars.mds.yandex.net/i?id=4796ab12d7cb5f88c663b50162e0bb585bbe388d-7012253-images-thumbs&n=13",
      "productName": "Mahsulot 1",
      "productCategory": "Kategoriya 1",
      "price": 100.00,
      "soldProducts": 20,
    },
    {
      "productId": "2",
      "productImage":
          "https://avatars.mds.yandex.net/i?id=4796ab12d7cb5f88c663b50162e0bb585bbe388d-7012253-images-thumbs&n=13",
      "productName": "Mahsulot 2",
      "productCategory": "Kategoriya 2",
      "price": 50.00,
      "soldProducts": 15,
    },
    {
      "productId": "1",
      "productImage":
          "https://avatars.mds.yandex.net/i?id=4796ab12d7cb5f88c663b50162e0bb585bbe388d-7012253-images-thumbs&n=13",
      "productName": "Mahsulot 1",
      "productCategory": "Kategoriya 1",
      "price": 100.00,
      "soldProducts": 20,
    },
    {
      "productId": "2",
      "productImage":
          "https://avatars.mds.yandex.net/i?id=4796ab12d7cb5f88c663b50162e0bb585bbe388d-7012253-images-thumbs&n=13",
      "productName": "Mahsulot 2asdadsdasdas",
      "productCategory": "Kategoriyaasdasdsadassd 2",
      "price": 50.00,
      "soldProducts": 15,
    },
    // ... Qolgan productlarni qo'shing
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            headingRowColor: MaterialStateProperty.all(
                Colors.grey.shade200), // Sarlavha rangi
            dataRowColor: MaterialStateProperty.all(Colors.white),
            border: TableBorder.all(color: Colors.grey.shade300),
            columns: [
              const DataColumn(label: Text('productId')),
              DataColumn(label: Text('ProductImage')),
              const DataColumn(label: Text('productName')),
              const DataColumn(label: Text('productCategory')),
              const DataColumn(label: Text('Narx')),
              const DataColumn(label: Text('Sotilgan Mahsulotlar')),
              const DataColumn(label: Text('Amallar')),
            ],
            rows: productsData.map((product) {
              return DataRow(
                cells: [
                  DataCell(
                      Text(product['productId'], textAlign: TextAlign.left)),
                  DataCell(
                    Container(
                      width: 100,
                      padding: EdgeInsets.symmetric(
                          vertical: 2), // Rasmning kengligini belgilash
                      child: Image.network(
                        product['productImage'],
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  DataCell(
                      Text(product['productName'], textAlign: TextAlign.left)),
                  DataCell(Text(product['productCategory'],
                      textAlign: TextAlign.left)),
                  DataCell(Text(product['price'].toString(),
                      textAlign: TextAlign.left)),
                  DataCell(Text(product['soldProducts'].toString(),
                      textAlign: TextAlign.center)),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Product qo'shish formasini ochish
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
