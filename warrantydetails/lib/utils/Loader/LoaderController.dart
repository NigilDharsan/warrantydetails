import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoaderController extends GetxController {
  var isLoading = false.obs;

  void showLoader(bool isLoad) {
    isLoading.value = isLoad;
  }

  void showLoaderAfterBuild(bool isLoad) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showLoader(isLoad);
    });
  }
}
