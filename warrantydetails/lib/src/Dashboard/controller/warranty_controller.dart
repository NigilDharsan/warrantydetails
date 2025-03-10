import 'package:get/get.dart';
import 'package:warrantydetails/src/Dashboard/Model/WarrantyListModel.dart';
import 'package:warrantydetails/src/Dashboard/repository/warranty_repo.dart';
import 'package:warrantydetails/src/Login/Model/LoginModel.dart';

class WarrantyController extends GetxController implements GetxService {
  final WarrantyRepo warrantyRepo;

  WarrantyController({required this.warrantyRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool hasMoreItems = true;
  var warrantyData = WarrantyData();
  WarrantyListModel? warrantyListData;
  LoginModel? successModelData;

  // Future<void> getWarrantyData(
  //     String searchText, int page, int pageSize) async {
  //   _isLoading = true;
  //   update();

  //   Response? response =
  //       await warrantyRepo.getWarrantyList(searchText, page, pageSize);
  //   if (response != null && response.statusCode == 200) {
  //     warrantyListData = WarrantyListModel.fromJson(response.body);
  //   }

  //   _isLoading = false;
  //   update();
  // }

  // WarrantyListModel? warrantyListData = WarrantyListModel();

  Future<void> getWarrantyData(String query, int page, int limit) async {
    try {
      var response = await warrantyRepo.getWarrantyList(
          query, page, limit); // Fetch data from API

      if (response != null && response.statusCode == 200) {
        if (page == 1) {
          warrantyListData = WarrantyListModel.fromJson(response.body);
        } else {
          final newData = WarrantyListModel.fromJson(response.body);

          warrantyListData!.data?.addAll(newData.data ?? []); // Append new data
        }
      }

      if (warrantyListData!.data!.length < (warrantyListData?.count ?? 0)) {
        hasMoreItems = true;
      } else {
        hasMoreItems = false;
      }

      update();
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  Future<void> deleteWarrantyData(int itemID) async {
    _isLoading = true;
    update();

    Response? response = await warrantyRepo.deleteWarrantyItem(itemID);
    if (response != null && response.statusCode == 200) {
      successModelData = LoginModel.fromJson(response.body);
    } else {
      successModelData = LoginModel.fromJson(response?.body);
    }

    _isLoading = false;
    update();
  }
}
