import 'package:flutter/material.dart';

class EditableRow extends StatelessWidget {
  final String label;
  final TextEditingController textController;
  final String selectedCategory;

  const EditableRow({
    Key? key,
    required this.label,
    required this.textController,
    required this.selectedCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          TextFormField(
            controller: textController,
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
            validator: (value) {
              return _getValidationMessage(value, label, selectedCategory);
            },
          ),
        ],
      ),
    );
  }

  String? _getValidationMessage(String? value, String label, String category) {
    Map<String, List<String>> fields = {
      "Vehicle": [
        'Invoice No',
        'S.no',
        'Model',
        'Chase No',
        'Controller',
        'Motor',
        'Battery',
        'Charger',
        'Purchase Date',
        'Customer Name',
        'Phone No',
        'Email id',
        'Address'
      ],
      "Battery": [
        'Invoice No',
        'S.no',
        'Remarks',
        'Model',
        'Purchase Date',
        'Customer Name',
        'Phone No',
        'Email id',
        'Address'
      ],
      "Charger": [
        'Invoice No',
        'S.no',
        'Model',
        'Purchase Date',
        'Customer Name',
        'Phone No',
        'Email id',
        'Address'
      ],
    };

    // Only validate the fields in the selected category
    if (fields[category]?.contains(label) ?? false) {
      if (value == null || value.isEmpty) {
        return 'Please enter $label';
      }

      // Specific validations for "Email id" and "Phone No"
      if (label == "Email id" && !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
        return 'Please enter a valid email address';
      }

      if (label == "Phone No" && !RegExp(r'^[0-9]{10}$').hasMatch(value)) {
        return 'Please enter a valid 10-digit phone number';
      }
    }

    return null; // Return null if no validation errors
  }
}