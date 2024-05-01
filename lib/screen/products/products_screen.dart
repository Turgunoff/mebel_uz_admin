import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];

  void _pickImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      setState(() {
        imageFileList.addAll(selectedImages);
      });
    }
  }

  void _submitForm() async {
    // Form ma'lumotlarini to'plash
    final name = _nameController.text;
    final description = _descriptionController.text;
    final price = double.tryParse(_priceController.text);

    // Yuklashni tekshirish (agar kerak bo'lsa)
    if (name.isEmpty || description.isEmpty || price == null) {
      // Xato xabari ko'rsatish
      return;
    }

    // Rasmni serverga yuklash (agar kerak bo'lsa)
    // ...

    // Ma'lumotlar bazasida yangi mahsulot yozuvini yaratish
    // ...

    // Muvaffaqiyatli xabarni ko'rsatish
    // ...

    // Formni qayta tiklash
    _formKey.currentState!.reset();
    imageFileList.clear();
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
                    labelStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 14,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 10.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade200, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.red, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade200, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade400, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Iltimos, ma\'lumot kiriting';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Product Tavsifi',
                    labelStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 14,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 10.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade200, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.red, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade200, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade400, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Iltimos, ma\'lumot kiriting';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Product Narxi',
                    labelStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 14,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 10.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade200, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.red, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade200, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade400, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Iltimos, ma\'lumot kiriting';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Narx son bo\'lishi kerak';
                    }
                    return null;
                  },
                ),
                // ... Boshqa form maydonlari
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: imageFileList.isEmpty ? 0 : imageFileList.length,
                    itemBuilder: (context, index) => imageFileList.isEmpty
                        ? const SizedBox.shrink()
                        : Container(
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 1,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Stack(
                                // "X" tugma qo'shish uchun
                                alignment: Alignment.topRight,
                                children: [
                                  Image.file(
                                    File(imageFileList[index].path),
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                  ),
                                  IconButton(
                                    // "X" tugma
                                    onPressed: () {
                                      setState(() {
                                        imageFileList.removeAt(index);
                                      });
                                    },
                                    icon: const Icon(Icons.cancel,
                                        color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _pickImages,
                  child: const Text('Rasmlarni Tanlash'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Form yuborilsa _submitForm'ni chaqirish
                      _submitForm();
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
