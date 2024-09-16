import 'package:get/get.dart';
import 'package:globalpay/views/navbar/dashboard_screen.dart';
import 'package:globalpay/views/navbar/notification_screen.dart';

class NavbarController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final List page = [DashboardScreen(), NotificationScreen()];

  void selectedPage(int index) {
    selectedIndex.value = index;
  }
}
