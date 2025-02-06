import 'package:get/get.dart';
import 'package:warrantydetails/utils/Provider/client_api.dart';
import 'package:warrantydetails/utils/app_constants.dart';

class WarrantyRepo {
  final ApiClient apiClient;

  WarrantyRepo({required this.apiClient});

  Future<Response?> getWarrantyList() async {
    return await apiClient.getData(AppConstants.registrationUrl);
  }
  Future<Response?> deleteWarrantyList() async {
    return await apiClient.deleteData(AppConstants.registrationUrl);
  }
}
