import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController loginController = Get.put(LoginController());
  String? _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Login'),
      ),
      body: Form(
        key: loginController.formKey, // Access formKey from controller
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Iltimos, emailingizni kiriting';
                }
                return null;
              },
              onSaved: (value) => _email = value,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Parol'),
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Iltimos, parolingizni kiriting';
                }
                return null;
              },
              onSaved: (value) => _password = value,
            ),
            Obx(() => ElevatedButton(
                  child: loginController.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Kirish'),
                  onPressed: () async {
                    if (loginController.formKey.currentState!.validate()) {
                      loginController.formKey.currentState!.save();
                      await loginController.signInWithEmailAndPassword(
                          _email!, _password!);
                    }
                  },
                ))
          ],
        ),
      ),
    );
  }
}
