import 'package:get/get.dart';
import 'package:Benefeer/controller/auth.dart';
import 'package:Benefeer/controller/dashboard.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
    Get.put(AuthController());
  }
}