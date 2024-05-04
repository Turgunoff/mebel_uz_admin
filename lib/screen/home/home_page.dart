import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mebel_uz_admin/screen/categories/category_screen.dart';
import 'package:mebel_uz_admin/screen/dashboard/dashboard_screen.dart';
import 'package:mebel_uz_admin/screen/home/controller.dart';
import 'package:mebel_uz_admin/screen/orders/orders_screen.dart';
import 'package:mebel_uz_admin/screen/products/products_screen.dart';
import 'package:mebel_uz_admin/screen/users/users_screen.dart';

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
  final controller = Get.put(HomeController());

  var currentPage = DrawerSections.dashboard;

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.dashboard) {
      container = const DashboardScreen();
    } else if (currentPage == DrawerSections.categories) {
      container = CategoryScreen();
    } else if (currentPage == DrawerSections.products) {
      container = const ProductsScreen();
    } else if (currentPage == DrawerSections.orders) {
      container = const OrdersScreen();
    } else if (currentPage == DrawerSections.users) {
      container = const UsersScreen();
    }
    return GetBuilder<HomeController>(
      init: HomeController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Mebel uz'),
          ),
          drawer: Drawer(
            elevation: 0.0,
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          height: 120,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/logo/logo.png'),
                            ],
                          ),
                        ),
                        myDrawerList(),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey.shade200,
                    thickness: 1,
                  ),
                  ListTile(
                    title: const Text('Chiqish'),
                    trailing: const Icon(Iconsax.logout),
                    onTap: () {
                      if (controller.isLoading.value) {
                        // If loading, show indicator
                        Get.dialog(
                            const Center(child: CircularProgressIndicator()));
                      } else {
                        controller.signOut();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          body: container,
        );
      },
    );
  }

  Widget myDrawerList() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          menuItem(1, "Dashboard", Iconsax.home,
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(2, "Categories", Icons.people_alt_outlined,
              currentPage == DrawerSections.categories ? true : false),
          menuItem(3, "Products", Icons.event,
              currentPage == DrawerSections.products ? true : false),
          menuItem(4, "Orders", Icons.notes,
              currentPage == DrawerSections.orders ? true : false),
          menuItem(5, "Users", Icons.settings_outlined,
              currentPage == DrawerSections.users ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: selected ? Colors.green : Colors.transparent,
      child: InkWell(
        onTap: () {
          Get.back();
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
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black,
              fontSize: 16,
            ),
          ),
          leading: Icon(
            icon,
            color: selected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
