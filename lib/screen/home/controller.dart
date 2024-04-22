import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mebel_uz_admin/screen/login_page/login_page.dart';

class HomeController extends GetxController {
  final auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;

  Future<void> signOut() async {
    bool? result = await Get.defaultDialog(
      title: 'Chiqish',
      middleText: 'Siz rostdan ham chiqmoqchimisiz?',
      textConfirm: 'Ha',
      backgroundColor: Colors.white,
      textCancel: 'Yo\'q',
      confirmTextColor: Colors.white,
      onConfirm: () => Get.back(result: true),
      onCancel: () => Get.back(result: false),
    );

    if (result != null && result) {
      isLoading.value = true;
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      try {
        await auth.signOut();
        Get.offAll(const LoginScreen());
      } catch (e) {
        print('Chiqishda xatolik yuz berdi: $e');
      } finally {
        isLoading.value = false;
        if (Get.isDialogOpen!) {
          Get.back();
        }
      }
    }
  }
}
