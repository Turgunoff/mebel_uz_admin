import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mebel_uz_admin/screen/categories/add_category.dart';

import 'controller/controller.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});
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
              ? const Center(child: CircularProgressIndicator())
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
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        foregroundImage: NetworkImage(
                          category.categoryImage!,
                          scale: 1,
                        ),
                        foregroundColor: Colors.white,
                      ),
                      title: Text(category.categoryName),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
