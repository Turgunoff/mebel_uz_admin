import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mebel_uz_admin/screen/categories/category_screen.dart';
import 'package:mebel_uz_admin/screen/home/home_page.dart';
import 'package:mebel_uz_admin/screen/login_page/login_page.dart';
import 'package:mebel_uz_admin/screen/products/products_screen.dart';
import 'package:mebel_uz_admin/screen/users/users_screen.dart';

class SideMenuDrawer extends StatefulWidget {
  const SideMenuDrawer({super.key});

  @override
  State<SideMenuDrawer> createState() => _SideMenuDrawerState();
}

class _SideMenuDrawerState extends State<SideMenuDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0.0,
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                  child: Text('Mebel uz'),
                ),
                ListTile(
                  leading: const Icon(Iconsax.home),
                  title: const Text('Dashboard'),
                  onTap: () {
                    Get.back();
                    Get.to(() => HomeScreen(),
                        transition: Transition.cupertino);
                  },
                ),
                ListTile(
                  leading: const Icon(Iconsax.shop),
                  title: const Text('Buyurtmalar ro\'yxati'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Iconsax.category),
                  title: const Text('Kategoriyalar ro\'yxati'),
                  onTap: () {
                    Get.back();
                    Get.to(() => CategoryScreen(),
                        transition: Transition.cupertino);
                  },
                ),
                ListTile(
                  leading: const Icon(Iconsax.category),
                  title: const Text('Maxsulotlar ro\'yxati'),
                  onTap: () {
                    Get.back();
                    Get.to(() => ProductsScreen(),
                        transition: Transition.cupertino);
                  },
                ),
                ListTile(
                  leading: const Icon(Iconsax.user),
                  title: const Text('Foydalanuvchilar'),
                  onTap: () {
                    Get.back();
                    Get.to(() => UsersScreen(),
                        transition: Transition.cupertino);
                  },
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Chiqish'),
            trailing: const Icon(Iconsax.logout),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Get.offAll(const LoginScreen());
            },
          ),
        ],
      ),
    );
  }
}
