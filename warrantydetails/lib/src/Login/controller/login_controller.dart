import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:warrantydetails/src/Login/Model/LoginModel.dart';
import 'package:warrantydetails/src/Login/repository/login_repo.dart';

class LoginController extends GetxController implements GetxService {
  final LoginRepo loginRepo;

  LoginController({required this.loginRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool hasMoreItems = true;

  LoginModel? loginModel;

  var signInEmailController = TextEditingController();
  var signInPasswordController = TextEditingController();

  _hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  Future<void> login() async {
    _hideKeyboard();
    _isLoading = true;
    update();

    Response? response = await loginRepo.login(
        email: signInEmailController.value.text,
        password: signInPasswordController.value.text);
    if (response != null && response.statusCode == 200) {
      signInEmailController.clear();
      signInPasswordController.clear();

      loginModel = LoginModel.fromJson(response.body);
    }

    _isLoading = false;
    update();
  }
}
