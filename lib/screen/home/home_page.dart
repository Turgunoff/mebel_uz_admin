import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mebel_uz_admin/screen/categories/category_screen.dart';
import 'package:mebel_uz_admin/screen/dashboard/dashboard_screen.dart';
import 'package:mebel_uz_admin/screen/drawer/side_menu.dart';
import 'package:mebel_uz_admin/screen/orders/orders_screen.dart';
import 'package:mebel_uz_admin/screen/products/products_screen.dart';
import 'package:mebel_uz_admin/screen/users/users_screen.dart';

import '../login_page/login_page.dart';

enum DrawerSections {
  dashboard,
  categories,
  products,
  orders,
  users,
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = FirebaseAuth.instance;

  var currentPage = DrawerSections.dashboard;

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.dashboard) {
      container = const DashboardScreen();
    } else if (currentPage == DrawerSections.categories) {
      container = const CategoryScreen();
    } else if (currentPage == DrawerSections.products) {
      container = const ProductsScreen();
    } else if (currentPage == DrawerSections.orders) {
      container = const OrdersScreen();
    } else if (currentPage == DrawerSections.users) {
      container = const UsersScreen();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mebel uz'),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  color: Colors.green[700],
                  width: double.infinity,
                  height: 200,
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        height: 70,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                      ),
                      const Text(
                        "Rapid Tech",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        "info@rapidtech.dev",
                        style: TextStyle(
                          color: Colors.grey[200],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
      body: container,
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Dashboard", Icons.dashboard_outlined,
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(2, "Categories", Icons.people_alt_outlined,
              currentPage == DrawerSections.categories ? true : false),
          menuItem(3, "Products", Icons.event,
              currentPage == DrawerSections.products ? true : false),
          menuItem(4, "Orders", Icons.notes,
              currentPage == DrawerSections.orders ? true : false),
          const Divider(),
          menuItem(5, "Users", Icons.settings_outlined,
              currentPage == DrawerSections.users ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.dashboard;
            } else if (id == 2) {
              currentPage = DrawerSections.categories;
            } else if (id == 3) {
              currentPage = DrawerSections.products;
            } else if (id == 4) {
              currentPage = DrawerSections.orders;
            } else if (id == 5) {
              currentPage = DrawerSections.users;
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
