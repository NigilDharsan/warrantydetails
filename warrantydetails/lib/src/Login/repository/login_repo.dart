import 'package:get/get.dart';
import 'package:warrantydetails/utils/Provider/client_api.dart';
import 'package:warrantydetails/utils/app_constants.dart';

class LoginRepo {
  final ApiClient apiClient;

  LoginRepo({required this.apiClient});

  Future<Response?> getIssuesType() async {
    return await apiClient.getData(
        "api/types/search?page=1&pageSize=10&orderBy=name&filter=parentid=109");
  }

  Future<Response?> login(
      {required String email, required String password}) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
    };

    var body = {"email": email, "password": password};

    return await apiClient.postLoginData(AppConstants.loginUrl, body,
        headers: headers);
  }

  Future<Response?> registration(
      {required Map<String, dynamic> body} ) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
    };

    return await apiClient.postLoginData(AppConstants.registrationUrl, body,
        headers: headers);
  }
}
