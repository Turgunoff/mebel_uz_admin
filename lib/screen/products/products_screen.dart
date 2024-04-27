import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
          "https://i.pinimg.com/originals/fb/5e/6f/fb5e6f42c2dd1d35814ae4ff64a55ce0.png",
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
            columns: const [
              DataColumn(label: Text('Id')),
              DataColumn(label: Text('Rasmi')),
              DataColumn(label: Text('Nomi')),
              DataColumn(label: Text('Kategoriya')),
              DataColumn(label: Text('Narxi')),
              DataColumn(label: Text('Sotilgan Mahsulotlar')),
              DataColumn(label: Text('Amallar')),
            ],
            rows: productsData.map((product) {
              return DataRow(
                cells: [
                  DataCell(
                      Text(product['productId'], textAlign: TextAlign.left)),
                  DataCell(
                    Container(
                      width: 100,
                      padding: const EdgeInsets.symmetric(
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
          Get.to(() => const AddProduct());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();

  // Controllerlar
  final _nameController = TextEditingController();

  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];

  void _pickImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList.addAll(selectedImages);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mahsulot Qo\'shish'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Product Nomi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Iltimos, ma\'lumot kiriting';
                    }
                    return null; // To'g'ri formatda bo'lsa null qaytaring
                  },
                ),
                // ... Boshqa form maydonlari
                ElevatedButton(
                  onPressed: _pickImages,
                  child: Text('Rasmlarni Tanlash'),
                ),

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Form yuborilsa _submitForm'ni chaqirish
                      // _submitForm();
                    }
                  },
                  child: const Text('Qo\'shish'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
