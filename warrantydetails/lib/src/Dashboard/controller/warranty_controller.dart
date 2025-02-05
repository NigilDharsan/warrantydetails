import 'package:get/get.dart';
import 'package:warrantydetails/src/Dashboard/Model/WarrantyListModel.dart';
import 'package:warrantydetails/src/Dashboard/repository/warranty_repo.dart';

class WarrantyController extends GetxController implements GetxService {
  final WarrantyRepo warrantyRepo;

  WarrantyController({required this.warrantyRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool hasMoreItems = true;

  WarrantyListModel? warrantyListData;

  Future<void> getWarrantyData() async {
    _isLoading = true;
    update();

    Response? response = await warrantyRepo.getWarrantyList();
    if (response != null && response.statusCode == 200) {
      warrantyListData = WarrantyListModel.fromJson(response.body);
    }

    _isLoading = false;
    update();
  }
}
