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

  Future<void> getWarrantyData(
      String searchText, int page, int pageSize) async {
    _isLoading = true;
    update();

    Response? response =
        await warrantyRepo.getWarrantyList(searchText, page, pageSize);
    if (response != null && response.statusCode == 200) {
      warrantyListData = WarrantyListModel.fromJson(response.body);
    }

    _isLoading = false;
    update();
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
