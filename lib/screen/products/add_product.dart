import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mebel_uz_admin/screen/categories/models/category_model.dart';
import 'package:mebel_uz_admin/screen/products/controller/controller.dart';
import 'package:uuid/uuid.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();

  final controller = Get.put(ProductsController());

  // Controllerlar
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();

  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];
  String? _selectedCategoryId;
  String? _selectedCategoryName;

  void _pickImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      setState(() {
        imageFileList.addAll(selectedImages);
      });
    }
  }

  // Function to add product to Firestore
  Future<void> _addProductToFirestore({
    required String name,
    required String description,
    required double price,
    required int stockQuantity,
    required String categoryId,
    required String categoryName,
    required List<XFile> images,
    required bool isActive,
  }) async {
    // 1. Show a Loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      // 2. Upload images to Firebase Storage (if provided)
      List<String> imageUrls = await _uploadImagesToStorage(images);

      // 3. Create product document in Firestore
      CollectionReference productsCollection =
          FirebaseFirestore.instance.collection('Products');
      await productsCollection.add({
        'name': name,
        'description': description,
        'price': price,
        'stockQuantity': stockQuantity,
        'categoryId': categoryId,
        'categoryName': categoryName,
        'imageUrls': imageUrls,
        'isActive': isActive
      });

      // 4. If successful, clear the form & navigate to success screen
      _formKey.currentState!.reset();
      imageFileList.clear();
      Get.back();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Mahsulot qo\'shildi!')));
      // Optionally navigate to a success screen
    } catch (e) {
      // 5. Close the loading indicator and handle errors
      Navigator.pop(context); // Close the loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Xatolik: $e')),
      );
    }
  }

  // Function to upload images to Firebase Storage
  Future<List<String>> _uploadImagesToStorage(List<XFile> images) async {
    List<String> imageUrls = [];

    for (XFile imageFile in images) {
      // Generate unique file name
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      // Upload image to Firebase Storage
      Reference storageRef =
          FirebaseStorage.instance.ref().child('productImages/$fileName');
      UploadTask uploadTask = storageRef.putFile(File(imageFile.path));
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

      // Get the download URL of the uploaded image
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      imageUrls.add(downloadUrl);
    }

    return imageUrls;
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
                Obx(
                  () => DropdownButtonFormField<String>(
                    dropdownColor: Colors.white,
                    decoration: InputDecoration(
                      labelText: 'Categoriya',
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
                    value: _selectedCategoryId,
                    items: controller.categories
                        .map((category) => DropdownMenuItem<String>(
                              value: category.categoryId,
                              child: Text(category.categoryName),
                            ))
                        .toList(),
                    onChanged: (newCategoryId) {
                      setState(() {
                        _selectedCategoryId = newCategoryId;
                        CategoryModel selectedCategory = controller.categories
                            .firstWhere((category) =>
                                category.categoryId == newCategoryId);

                        _selectedCategoryName = selectedCategory.categoryName;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Iltimos, ma\'lumot kiriting';
                      }
                      return null;
                    },
                  ),
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
                      final String name = _nameController.text;
                      final String description = _descriptionController.text;
                      final double price =
                          double.tryParse(_priceController.text) ?? 0.0;
                      final int stockQuantity =
                          int.tryParse(_quantityController.text) ?? 0;
                      _addProductToFirestore(
                        name: name,
                        description: description,
                        price: price,
                        stockQuantity: stockQuantity,
                        categoryId: _selectedCategoryId!,
                        categoryName: _selectedCategoryName!,
                        images: imageFileList,
                        isActive: true,
                      );
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
      controller: controller,
      decoration: InputDecoration(
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
    );
  }
}
