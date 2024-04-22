import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'controller/controller.dart';
import 'models/model.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});
  final controller = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(AddCategoryScreen()),
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        if (controller.categories.isEmpty) {
          return const Center(child: Text('No categories found'));
        } else {
          return controller.isLoading.value // Check the loading state
              ? const Center(
                  child:
                      CircularProgressIndicator()) // Show indicator if loading
              : RefreshIndicator(
                  onRefresh: controller.refreshData,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey.shade200,
                    ),
                    shrinkWrap: false,
                    itemCount: controller.categories.length,
                    itemBuilder: (context, index) {
                      final category = controller.categories[index];
                      return ListTile(
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            // controller.deleteCategory(category);
                          },
                        ),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          foregroundImage: NetworkImage(
                            category.categoryImage,
                            scale: 1,
                          ),
                          foregroundColor: Colors.white,
                        ),
                        title: Text(category.categoryName),
                      );
                    },
                  ),
                );
        }
      }),
    );
  }
}

class AddCategoryScreen extends StatefulWidget {
  AddCategoryScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yangi kategoriya qo\'shish'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _categoryNameController,
              decoration: const InputDecoration(
                hintText: 'Kategoriya nomi...',
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

                  // Create a new CategoryModel object
                  CategoryModel newCategory = CategoryModel(
                    categoryId: '', // Let Firestore generate ID
                    categoryName: _categoryNameController.text,
                    categoryImage: '', // Replace with image upload later
                  );

                  try {
                    // Add the category to Firestore
                    await controller.addCategory(
                        newCategory); // Call your controller's add function

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
    );
  }
}
