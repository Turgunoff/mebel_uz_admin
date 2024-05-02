import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
                      DataColumn(label: Text('Id')),
                      DataColumn(label: Text('Rasmi')),
                      DataColumn(label: Text('Nomi')),
                      DataColumn(label: Text('Kategoriya')),
                      DataColumn(label: Text('Narxi')),
                      DataColumn(label: Text('Sotilgan Mahsulotlar')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('Amallar')),
                    ],
                    rows: controller.products.map((product) {
                      return DataRow(
                        cells: [
                          DataCell(Text(product.id, textAlign: TextAlign.left)),
                          DataCell(
                            Container(
                              width: 100,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2), // Rasmning kengligini belgilash
                              child: Image.network(
                                product.imageUrl,
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
                          DataCell(Text('product.category',
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
  final _quantityController = TextEditingController();

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
                buildTextFormField(
                  controller: _nameController,
                  labelText: 'Product Nomi',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Iltimos, ma\'lumot kiriting';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                buildTextFormField(
                  controller: _descriptionController,
                  labelText: 'Product Tavsifi',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Iltimos, ma\'lumot kiriting';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                buildTextFormField(
                  labelText: "Product Narxi",
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Iltimos, ma\'lumot kiriting';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                buildTextFormField(
                  labelText: "Product soni",
                  controller: _quantityController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Iltimos, ma\'lumot kiriting';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
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
                                        size: 20, color: Colors.red),
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

  Widget buildTextFormField({
    required String labelText,
    required TextEditingController controller,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      // controller: _nameController,
      controller: controller,
      decoration: InputDecoration(
        // labelText: 'Product Nomi',
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.grey.shade500,
          fontSize: 14,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: validator,
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return 'Iltimos, ma\'lumot kiriting';
      //   }
      //   return null;
      // },
    );
  }
}
