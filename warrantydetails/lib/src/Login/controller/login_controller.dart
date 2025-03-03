import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warrantydetails/src/Login/Model/LoginModel.dart';
import 'package:warrantydetails/src/Login/repository/login_repo.dart';
import 'package:warrantydetails/utils/Language/Language.dart';

class LoginController extends GetxController implements GetxService {
  final LoginRepo loginRepo;

  LoginController({required this.loginRepo});

  // bool _isLoading = false;
  // bool get isLoading => _isLoading;
  // bool hasMoreItems = true;
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  bool hasMoreItems = true;
  void setLoading(bool value) {
    _isLoading.value = value;
    update(); // Notify UI
  }

  LoginModel? loginModel;

  var signInEmailController = TextEditingController();
  var signInPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var selectedCategory = "Vehicle".obs;
  var categories = <String>["Vehicle", "Battery", "Charger"].obs;

  Map<String, Map<String, TextEditingController>> categoryFields = {
    "Vehicle": {
      'invoice': TextEditingController(),
      'Serial Number': TextEditingController(),
      'Model': TextEditingController(),
      'Chase Number': TextEditingController(),
      'Controller': TextEditingController(),
      'Motor': TextEditingController(),
      'battery_number': TextEditingController(),
      'Charger': TextEditingController(),
      'Purchase Date': TextEditingController(),
      'Customer Name': TextEditingController(),
      'Phone Number': TextEditingController(),
      'Email id': TextEditingController(),
      'Address': TextEditingController(),
    },
    "Battery": {
      'invoice': TextEditingController(),
      'Serial Number': TextEditingController(),
      'Remarks': TextEditingController(),
      'Model': TextEditingController(),
      'Purchase Date': TextEditingController(),
      'Customer Name': TextEditingController(),
      'Phone Number': TextEditingController(),
      'Email id': TextEditingController(),
      'Address': TextEditingController(),
    },
    "Charger": {
      'invoice': TextEditingController(),
      'Serial Number': TextEditingController(),
      'Model': TextEditingController(),
      'Purchase Date': TextEditingController(),
      'Customer Name': TextEditingController(),
      'Phone Number': TextEditingController(),
      'Email id': TextEditingController(),
      'Address': TextEditingController(),
    }
  };

  Map<String, TextEditingController> get vehicle => categoryFields['Vehicle']!;
  Map<String, TextEditingController> get battery => categoryFields['Battery']!;
  Map<String, TextEditingController> get charger => categoryFields['Charger']!;

  _hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  Future<void> login() async {
    _hideKeyboard();
    setLoading(true);
    update();
    await Future.delayed(Duration(seconds: 2));
    Response? response = await loginRepo.login(
        email: signInEmailController.value.text,
        password: signInPasswordController.value.text);
    if (response != null && response.statusCode == 200) {
      signInEmailController.clear();
      signInPasswordController.clear();
      loginModel = LoginModel.fromJson(response.body);
    }

    setLoading(false);
    update();
  }

  Future<void> submitData() async {
    if (formKey.currentState!.validate()) {
      Map<String, TextEditingController> activeControllers =
          getActiveControllers();
      Map<String, dynamic> data = {
        "type": selectedCategory.value,
        for (var entry in activeControllers.entries) ...{
          if (entry.key == "invoice") "invoice": entry.value.text,
          if (entry.key == "Serial Number") "serial_number": entry.value.text,
          if (entry.key == "Model") "model": entry.value.text,
          if (entry.key == "Chase Number") "chno": entry.value.text,
          if (entry.key == "Controller") "controller": entry.value.text,
          if (entry.key == "Motor") "motor": entry.value.text,
          if (entry.key == "battery_number") "battery_no": entry.value.text,
          if (entry.key == "Charger") "charge": entry.value.text,
          if (entry.key == "Purchase Date") "purchase_date": entry.value.text,
          if (entry.key == "Customer Name") "customer_name": entry.value.text,
          if (entry.key == "Phone Number") "phone_number": entry.value.text,
          if (entry.key == "Email Id") "email": entry.value.text,
          if (entry.key == "Address") "address": entry.value.text,
          if (entry.key == "Remarks") "remark": entry.value.text,
        }
      };

      print("Submitted Data: $data");

      _hideKeyboard();
      setLoading(true);
      update();

      Response? response = await loginRepo.registration(body: data);
      if (response != null && response.statusCode == 201) {
        loginModel = LoginModel.fromJson(response.body);
        activeControllers.forEach((key, controller) {
          controller.clear();
        });
      }

      setLoading(false);
      update();
    }
  }

  Map<String, TextEditingController> getActiveControllers() {
    String category = selectedCategory.value;

    switch (category) {
      case "Vehicle":
        return vehicle;
      case "Battery":
        return battery;
      case "Charger":
        return charger;
      default:
        return vehicle;
    }
  }

  void changeLanguage(String lang) {
    Locale locale = Locale(lang);
    Get.updateLocale(locale);
    saveLocale(locale);
  }
}
