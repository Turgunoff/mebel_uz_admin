import 'package:get/get.dart';

enum DrawerSections {
  dashboard,
  categories,
  products,
  orders,
  users,
}

class HomeController extends GetxController {
  Rx<DrawerSections> currentPage = DrawerSections.dashboard.obs;

  void updateCurrentPage(DrawerSections section) {
    currentPage.value = section;
  }
}
