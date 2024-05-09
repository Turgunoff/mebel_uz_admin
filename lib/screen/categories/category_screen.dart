import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mebel_uz_admin/screen/categories/add_category.dart';

import 'controller/controller.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final controller = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.refreshData,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => const AddCategoryScreen());
          },
          child: const Icon(Icons.add),
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const Center(
                  child: Text('Yuklanmoqda...', style: TextStyle(fontSize: 20)),
                )
              : ListView.separated(
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
                          controller.deleteCategory(category);
                        },
                      ),
                      leading: Row(
                        // Using a Row for grouping the visibility icon and image
                        mainAxisSize:
                            MainAxisSize.min, // Important for correct spacing
                        children: [
                          IconButton(
                            icon: Icon(
                              category.isVisibility
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: category.isVisibility
                                  ? Colors.green
                                  : Colors.grey.shade900,
                            ),
                            onPressed: () {
                              category.isVisibility =
                                  !category.isVisibility; // Toggle visibility
                              controller.updateCategoryVisibility(
                                  category); // Update in Firestore (implement this)
                              setState(() {
                                controller.update(); // Update GetX
                              });
                            },
                          ),
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: CachedNetworkImage(
                              imageUrl: category.categoryImage,
                              fit: BoxFit.contain,
                              placeholder: (context, url) => const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ],
                      ),
                      title: Text(category.categoryNameUz),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
