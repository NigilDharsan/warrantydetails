import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  var selectedCategory = "Vehicle".obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var invoice = TextEditingController();
  var serialNumber = TextEditingController();
  var model = TextEditingController();
  var chno = TextEditingController();
  var controller = TextEditingController();
  var motor = TextEditingController();
  var batteryNo = TextEditingController();
  var charge = TextEditingController();
  var purchaseDate = TextEditingController();
  var customerName = TextEditingController();
  var phoneNumber = TextEditingController();
  var email = TextEditingController();
  var address = TextEditingController();

  List<String> categories = ["Vehicle", "Charger", "Battery"];

  Map<String, Map<String, TextEditingController>> categoryFields = {
    "Vehicle": {
      'Invoice No': TextEditingController(),
      'S.no': TextEditingController(),
      'Model': TextEditingController(),
      'Chase No': TextEditingController(),
      'Controller': TextEditingController(),
      'Motor': TextEditingController(),
      'Battery': TextEditingController(),
      'Charger': TextEditingController(),
      'Purchase Date': TextEditingController(),
      'Customer Name': TextEditingController(),
      'Phone No': TextEditingController(),
      'Email id': TextEditingController(),
      'Address': TextEditingController(),
    },
    "Battery": {
      'Invoice No': TextEditingController(),
      'S.no': TextEditingController(),
      'Remarks': TextEditingController(),
      'Model': TextEditingController(),
      'Purchase Date': TextEditingController(),
      'Customer Name': TextEditingController(),
      'Phone No': TextEditingController(),
      'Email id': TextEditingController(),
      'Address': TextEditingController(),
    },
    "Charger": {
      'Invoice No': TextEditingController(),
      'S.no': TextEditingController(),
      'Model': TextEditingController(),
      'Purchase Date': TextEditingController(),
      'Customer Name': TextEditingController(),
      'Phone No': TextEditingController(),
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
  Future<void> submitData() async {
    if (formKey.currentState!.validate()) {
      Map<String,
          TextEditingController> activeControllers = getActiveControllers();
      Map<String, dynamic> data = {
        // 'invoice': invoice.text,
        // 'serial_number':  serialNumber.text,
        // 'model':  model.text,
        // 'chno':  chno.text,
        // 'controller': controller.text,
        // 'motor':motor.text,
        // 'battery_no': batteryNo.text,
        // 'charge':  charge.text,
        // 'purchase_date': purchaseDate.text,
        // 'customer_name':  customerName.text,
        // 'phone_number':  phoneNumber.text,
        // 'email': email.text,
        // 'address': address.text,
        for (var entry in activeControllers.entries) entry.key: entry.value
            .text,
      };

      print("Submitted Data: $data");

      _hideKeyboard();
      _isLoading = true;
      update();

      Response? response = await loginRepo.registration(body:data);
      if (response != null && response.statusCode == 200) {

        // loginModel = LoginModel.fromJson(response.body);
      }
      activeControllers.forEach((key, controller) {
        // controller.clear();
      });
      // _isLoading = false;
    }
  }
  Map<String, TextEditingController> getActiveControllers() {
    switch (selectedCategory.value) {
      case "Vehicle":
        return vehicle;
      case "Battery":
        return battery;
      case "Charger":
        return charger;
      default:
        return {};
    }
  }


//   Future<void> submitData() async {
//     if (formKey.currentState!.validate()) {
//       Map<String, dynamic> data = {
//           'invoice': vehicle['invoice']?.text,
//         'serial_number':  vehicle['serialNumber']?.text,
//         'model':  vehicle ['model']?.text,
//         'chno':  vehicle ['chno']?.text,
//         'controller':  vehicle['controller']?.text,
//         'motor': vehicle ['motor']?.text,
//         'battery_no':  vehicle ['batteryNo']?.text,
//         'charge':  vehicle['charge']?.text,
//         'purchase_date': vehicle['purchaseDate']?.text,
//         'customer_name':  vehicle['customerName']?.text,
//         'phone_number':  vehicle['phoneNumber']?.text,
//         'email': vehicle ['email']?.text,
//         'address': vehicle ['address']?.text,
//       };
//       Map<String, dynamic> data = {
//         'invoice': battery['invoice']?.text,
//         'serial_number':  battery['serialNumber']?.text,
//         'model':  battery ['model']?.text,
//         'chno':  battery ['chno']?.text,
//         'controller':  battery['controller']?.text,
//         'motor': battery ['motor']?.text,
//         'battery_no':  battery ['batteryNo']?.text,
//         'charge':  battery['charge']?.text,
//         'purchase_date': battery['purchaseDate']?.text,
//         'customer_name':  battery['customerName']?.text,
//         'phone_number':  battery['phoneNumber']?.text,
//         'email': battery ['email']?.text,
//         'address': battery ['address']?.text,
//       };
//       Map<String, dynamic> data = {
//         'invoice': charger['invoice']?.text,
//         'serial_number':  charger['serialNumber']?.text,
//         'model':  charger ['model']?.text,
//         'chno':  charger ['chno']?.text,
//         'controller':  charger['controller']?.text,
//         'motor': charger ['motor']?.text,
//         'battery_no':  charger ['batteryNo']?.text,
//         'charge':  charger['charge']?.text,
//         'purchase_date': charger['purchaseDate']?.text,
//         'customer_name':  charger['customerName']?.text,
//         'phone_number':  charger['phoneNumber']?.text,
//         'email': charger ['email']?.text,
//         'address': charger ['address']?.text,
//       };
//
//       print(data);
//       categoryFields[selectedCategory.value]?.forEach((key, controller) {
//         //       controller.clear();
//         //     });
//       // _hideKeyboard();
//       // _isLoading = true;
//       // update();
//       //
//       // Response? response = await loginRepo.registration(body:data);
//       // if (response != null && response.statusCode == 200) {
//       //
//       //   loginModel = LoginModel.fromJson(response.body);
//       // }
//       //
//       // _isLoading = false;
//       // update();
//     }
//   }
}
