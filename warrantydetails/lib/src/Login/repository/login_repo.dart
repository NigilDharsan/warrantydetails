import 'package:get/get.dart';
import 'package:warrantydetails/utils/Provider/client_api.dart';

class LoginRepo {
  final ApiClient apiClient;

  LoginRepo({required this.apiClient});

  Future<Response?> getIssuesType() async {
    return await apiClient.getData(
        "api/types/search?page=1&pageSize=10&orderBy=name&filter=parentid=109");
  }
}
