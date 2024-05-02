import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mebel_uz_admin/screen/categories/models/category_model.dart';

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

  List<CategoryModel> _categories = []; // Kategoriyalarni saqlashi uchun
  String? _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  //Firestore`dan kategoriyalarni olib kelish
  Future<void> _fetchCategories() async {
    CollectionReference categoriesCollection =
        FirebaseFirestore.instance.collection('Categories');
    QuerySnapshot querySnapshot = await categoriesCollection.get();

    setState(() {
      _categories = querySnapshot.docs.map((doc) {
        if (doc.data() is Map<String, dynamic>) {
          return CategoryModel.fromJson(doc.data() as Map<String, dynamic>);
        } else {
          // Handle unexpected situations here
          throw Exception('Document data is not a Map');
        }
      }).toList();
    });
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
                DropdownButtonFormField<String>(
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
                  items: _categories
                      .map((category) => DropdownMenuItem<String>(
                            value: category.categoryId,
                            child: Text(category.categoryName),
                          ))
                      .toList(),
                  onChanged: (newCategoryId) {
                    setState(() {
                      _selectedCategoryId = newCategoryId;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Iltimos, ma\'lumot kiriting';
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
