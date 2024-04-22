import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mebel_uz_admin/screen/home/home_page.dart';

class LoginController extends GetxController {
  final auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;
  final _formKey = GlobalKey<FormState>();

  // Getter for the formKey
  GlobalKey<FormState> get formKey => _formKey;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    isLoading.value = true; // Set loading to true
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.offAll(const HomeScreen()); // Navigate on success
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        backgroundColor: Theme.of(Get.context!).colorScheme.error,
        content: const Text('Email yoki parol noto\'g\'ri'),
      ));
    } finally {
      isLoading.value = false; // Reset loading state
    }
  }
}
