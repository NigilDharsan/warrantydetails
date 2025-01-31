import 'package:flutter/material.dart';

class Warrantyregistration extends StatefulWidget {
  const Warrantyregistration({super.key});

  @override
  State<Warrantyregistration> createState() => _WarrantyregistrationState();
}

class _WarrantyregistrationState extends State<Warrantyregistration> {
  String? selectedCategory = "Vehicle"; // Default selection
  bool showForm = true;

  final Map<String, TextEditingController> vehicle = {
    'Invoice No': TextEditingController(),
    'S.no': TextEditingController(),
    'Model': TextEditingController(),
    'Chase No': TextEditingController(),
    'Controller': TextEditingController(),
    'Motor': TextEditingController(),
    'Purchase Date': TextEditingController(),
    'Customer Name': TextEditingController(),
    'Phone No': TextEditingController(),
    'Email id': TextEditingController(),
    'Address': TextEditingController(),
  };

  final Map<String, TextEditingController> battery = {
    'Invoice No': TextEditingController(),
    'S.no': TextEditingController(),
    'Model': TextEditingController(),
    'Purchase Date': TextEditingController(),
    'Customer Name': TextEditingController(),
    'Phone No': TextEditingController(),
    'Email id': TextEditingController(),
    'Address': TextEditingController(),
  };

  final Map<String, TextEditingController> charger = {
    'Invoice No': TextEditingController(),
    'S.no': TextEditingController(),
    'Model': TextEditingController(),
    'Purchase Date': TextEditingController(),
    'Customer Name': TextEditingController(),
    'Phone No': TextEditingController(),
    'Email id': TextEditingController(),
    'Address': TextEditingController(),
  };

  List<String> categories = ["Vehicle", "Charger", "Battery"];

  Map<String, String> getSelectedData() {
    if (selectedCategory == "Vehicle") {
      return vehicle.map((key, value) => MapEntry(key, value.text));
    } else if (selectedCategory == "Battery") {
      return battery.map((key, value) => MapEntry(key, value.text));
    } else if (selectedCategory == "Charger") {
      return charger.map((key, value) => MapEntry(key, value.text));
    }
    return {};
  }

  void submitData() {
    Map<String, String> selectedData = getSelectedData();
    print("Submitted Data for $selectedCategory: $selectedData");

  }

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Text('Select Your Product',
             style: TextStyle(
               fontSize: 13,
               color: Colors.red,
               fontWeight: FontWeight.bold,
             ),),
              SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedCategory,
                    isExpanded: true,
                    dropdownColor: Colors.red[50],
                    items: categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(
                          category,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCategory = newValue;
                        showForm = selectedCategory != null;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              showForm
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (selectedCategory == "Vehicle")
                    ...vehicle.entries.map((entry) => _buildEditableRow(entry.key, entry.value)),
                  if (selectedCategory == "Battery")
                    ...battery.entries.map((entry) => _buildEditableRow(entry.key, entry.value)),
                  if (selectedCategory == "Charger")
                    ...charger.entries.map((entry) => _buildEditableRow(entry.key, entry.value)),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: submitData,
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
                  : const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditableRow(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.red[50],
              contentPadding: const EdgeInsets.all(12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.red[100] ?? Colors.red),
              ),
            ),
            style: TextStyle(fontSize: 14, color: Colors.red[400]),
          ),
        ],
      ),
    );
  }
}
