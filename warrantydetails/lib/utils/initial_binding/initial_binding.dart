import 'package:get/get.dart';
import 'package:warrantydetails/src/Dashboard/controller/warranty_controller.dart';
import 'package:warrantydetails/src/Dashboard/repository/warranty_repo.dart';
import 'package:warrantydetails/src/Login/controller/login_controller.dart';
import 'package:warrantydetails/src/Login/repository/login_repo.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() async {
    //common controller'

    Get.lazyPut(
        () => LoginController(loginRepo: LoginRepo(apiClient: Get.find())));
    Get.lazyPut(() =>
        WarrantyController(warrantyRepo: WarrantyRepo(apiClient: Get.find())));
  }
}
