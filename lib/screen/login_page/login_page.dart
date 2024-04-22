import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;

  String? _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Login'),
      ),
      body: Form(
        key: _formKey,
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
            ElevatedButton(
              child: const Text('Kirish'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  try {
                    await _auth.signInWithEmailAndPassword(
                        email: _email!, password: _password!);
                    Get.offAll(const HomeScreen());
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Email yoki parol noto\'g\'ri')));
                    print('Error ----------------------- $e');
                    // bu yerda xatolikni foydalanuvchiga ko'rsatish kodi bo'ladi
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
