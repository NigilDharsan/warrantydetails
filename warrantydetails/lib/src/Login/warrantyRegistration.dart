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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Center(
            child: Text(
              'Warranty Registration',
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
        }));
  }

  MainUI(context, controller) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: controller.formKey, // Use the formKey for validation
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Select Your Product',
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
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      value: controller.selectedCategory.value,
                      isExpanded: true,
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      iconStyleData: IconStyleData(
                        icon: Icon(Icons.arrow_drop_down, color: Colors.red),
                      ),
                      style: TextStyle(color: Colors.red),
                      items: controller.categories
                          .map<DropdownMenuItem<String>>(
                              (String category) => DropdownMenuItem<String>(
                                    value: category,
                                    child: Text(
                                      category,
                                      style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ))
                          .toList(),
                      onChanged: (String? category) {
                        if (category != null) {
                          controller.selectedCategory.value = category;
                          controller.formKey.currentState
                              ?.reset(); // Reset form on category change
                          controller.update(); // Ensure UI updates
                          print("Category changed to: $category"); // Debugging
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
                      if (controller.selectedCategory.value == "Vehicle")
                        ...controller.vehicle.entries.map(
                          (entry) => EditableRow(
                            label: entry.key,
                            textController: entry.value,
                            selectedCategory: controller.selectedCategory.value,
                          ),
                        ),
                      if (controller.selectedCategory.value == "Battery")
                        ...controller.battery.entries.map(
                          (entry) => EditableRow(
                            label: entry.key,
                            textController: entry.value,
                            selectedCategory: controller.selectedCategory.value,
                          ),
                        ),
                      if (controller.selectedCategory.value == "Charger")
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
                  // Wrap the button in GetBuilder to ensure state updates
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
                            Get.back();
                          } else {
                            customSnackBar(controller.loginModel?.message,
                                isError: true);
                          }
                        }
                      },
                      child: const Text(
                        "Submit",
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
