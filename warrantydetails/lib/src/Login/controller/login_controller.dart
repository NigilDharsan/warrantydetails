import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:warrantydetails/src/Login/repository/login_repo.dart';

class LoginController extends GetxController implements GetxService {
  final LoginRepo loginRepo;

  LoginController({required this.loginRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool hasMoreItems = true;

  // Future<IssuesTypeModel?> getIssuesType() async {
  //   _isLoading = true;
  //   loaderController.showLoaderAfterBuild(_isLoading);

  //   final response = await compliantRepo.getIssuesType();
  //   if (response != null && response.statusCode == 200) {
  //     issuesTypeModeldata = IssuesTypeModel.fromJson(response.body);

  //     print("GET UCO DETAIL RESPONSE ${response.body}");
  //     _isLoading = false;
  //     loaderController.showLoaderAfterBuild(_isLoading);

  //     update();
  //     return issuesTypeModeldata;
  //   }

  //   _isLoading = false;
  //   loaderController.showLoaderAfterBuild(_isLoading);

  //   update();
  // }
}
