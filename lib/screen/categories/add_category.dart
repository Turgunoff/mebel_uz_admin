import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mebel_uz_admin/screen/categories/controller/controller.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final _formKey = GlobalKey<FormState>();

  final _categoryNameController = TextEditingController();
  final controller = Get.put(CategoryController());

  @override
  void dispose() {
    _categoryNameController.dispose();
    super.dispose();
  }

  Future<void> _selectImage(String imageUrl) async {
    controller.selectedImage = imageUrl;
    setState(() {
      print(imageUrl);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yangi kategoriya qo\'shish'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              GetBuilder<CategoryController>(
                init: CategoryController(),
                initState: (_) {},
                builder: (_) {
                  if (controller.imageUrls.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.imageUrls.length,
                        itemBuilder: (context, index) {
                          final imageUrl = controller.imageUrls[index];
                          return GestureDetector(
                            onTap: () => _selectImage(imageUrl),
                            child: Container(
                              width: 100,
                              height: 100,
                              padding: const EdgeInsets.all(8.0),
                              margin: const EdgeInsets.only(left: 8.0),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: controller.selectedImage == imageUrl
                                      ? Colors.blue
                                      : Colors.transparent,
                                  width: 2.0,
                                ),
                              ),
                              child: SvgPicture.network(
                                imageUrl,
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _categoryNameController,
                decoration: InputDecoration(
                  labelText: 'kategoriya nomi',
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
                    borderSide: const BorderSide(color: Colors.red, width: 1.0),
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
                    return 'Kategoriya nomini kiriting';
                  }
                  return null;
                },
                // onSaved: (value) => _categoryNameController = value,
              ),
              ElevatedButton(
                child: const Text('Qo\'shish'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save(); // Save form values

                    try {
                      // Add the category to Firestore
                      await controller.addCategory(
                        _categoryNameController.text,
                        controller
                            .selectedImage!, // Replace with image upload later
                      );

                      // Navigate back to CategoryScreen
                      Get.back();

                      // Show a success message (optional)
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Kategoriya muvaffaqiyatli qo\'shildi!'),
                      ));
                    } catch (e) {
                      // Handle errors (print or show error message)
                      print('Kategoriya qo\'shishda xatolik yuz berdi: $e');
                      // Consider using a snackbar or modal to display errors to the user
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
