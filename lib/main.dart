import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mebel_uz_admin/firebase_options.dart';
import 'package:mebel_uz_admin/screen/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mebel uz',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.green,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green),
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white, // Set your desired background color
          elevation: 0.0, // Remove any default elevation
          titleTextStyle: TextStyle(
            color: Colors.black, // Adjust title text color
            fontSize: 20.0,
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
