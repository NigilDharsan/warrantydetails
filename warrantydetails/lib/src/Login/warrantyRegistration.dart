import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warrantydetails/widget/custom_snackbar.dart';
import '../../widget/Common_Warranty_UI.dart';
import 'controller/login_controller.dart';

class Warrantyregistration extends StatefulWidget {
  const Warrantyregistration({super.key});

  @override
  State<Warrantyregistration> createState() => _WarrantyregistrationState();
}

class _WarrantyregistrationState extends State<Warrantyregistration> {

  bool _isDownloading = false;

  @override
  Widget build(BuildContext context) {
    return  RefreshIndicator(
      onRefresh: () async {
        if (_isDownloading) {
          const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            ),
          );
        };// Your refresh logic here
      },
      child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Center(
          child: Text(
            'warranty'.tr,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: GetBuilder<LoginController>(builder: (controller) {
        return MainUI(context, controller);
      }),),
    );
  }

  MainUI(context, controller) {
    print(controller.categories);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: controller.formKey, // Use the formKey for validation
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'select your product'.tr,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Obx(
                () => Container(
                  height: 50,
                  width: double.infinity,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      value: controller.categories
                              .contains(controller.selectedCategory.value)
                          ? controller.selectedCategory.value
                          : null,
                      items: controller.categories
                          .toSet()
                          .map<DropdownMenuItem<String>>(
                            (String category) => DropdownMenuItem<String>(
                              value: category, // Store raw value
                              child:
                                  Text(category.tr), // Display translated text
                            ),
                          )
                          .toList(),
                      onChanged: (String? category) {
                        if (category != null) {
                          controller.selectedCategory.value = category;
                          controller.update();
                          controller.formKey.currentState?.reset();
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controller.selectedCategory.value.isNotEmpty &&
                          controller.selectedCategory.value == "Vehicle")
                        ...controller.vehicle.entries.map(
                          (entry) => EditableRow(
                            label: entry.key,
                            textController: entry.value,
                            selectedCategory: controller.selectedCategory.value,
                          ),
                        ),
                      if (controller.selectedCategory.value.isNotEmpty &&
                          controller.selectedCategory.value == "Battery")
                        ...controller.battery.entries.map(
                          (entry) => EditableRow(
                            label: entry.key,
                            textController: entry.value,
                            selectedCategory: controller.selectedCategory.value,
                          ),
                        ),
                      if (controller.selectedCategory.value.isNotEmpty &&
                          controller.selectedCategory.value == "Charger")
                        ...controller.charger.entries.map(
                          (entry) => EditableRow(
                            label: entry.key,
                            textController: entry.value,
                            selectedCategory: controller.selectedCategory.value,
                          ),
                        ),
                    ],
                  )),
              const SizedBox(height: 20),
              Center(
                child: GetBuilder<LoginController>(
                  builder: (controller) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () async {
                        if (controller.formKey.currentState!.validate()) {
                          print("Submit button clicked"); // Debugging
                          await controller.submitData(); // Call the function
                          if (controller.loginModel?.status == "True") {
                            customSnackBar("Warranty Registration Successfully",
                                isError: false);
                            Navigator.pop(context, true);
                          } else {
                            customSnackBar(controller.loginModel?.message,
                                isError: true);
                          }
                        }
                      },
                      child: Text(
                        "Submit".tr,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
