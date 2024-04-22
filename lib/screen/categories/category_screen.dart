import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/controller.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});
  final controller = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        return controller.isLoading.value // Check the loading state
            ? const Center(
                child: CircularProgressIndicator()) // Show indicator if loading
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
      }),
    );
  }
}
