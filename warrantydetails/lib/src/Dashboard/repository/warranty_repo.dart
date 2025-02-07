import 'package:get/get.dart';
import 'package:warrantydetails/utils/Provider/client_api.dart';
import 'package:warrantydetails/utils/app_constants.dart';

class WarrantyRepo {
  final ApiClient apiClient;

  WarrantyRepo({required this.apiClient});

  Future<Response?> getWarrantyList(
      String searchText, int page, int pageSize) async {
    return await apiClient.getData(AppConstants.registrationUrl +
        "?serial_number=$searchText&page=$page&page_size=$pageSize");
  }

  Future<Response?> deleteWarrantyItem(int itemID) async {
    return await apiClient
        .deleteData(AppConstants.registrationUrl + "/$itemID");
  }
}
