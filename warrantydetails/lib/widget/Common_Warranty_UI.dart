import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditableRow extends StatefulWidget {
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
  _EditableRowState createState() => _EditableRowState();
}

class _EditableRowState extends State<EditableRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label.tr,
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          widget.label == "Purchase Date"
              ? InkWell(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        widget.textController.text =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                      });
                    }
                  },
                  child: TextFormField(
                    enabled: false,
                    controller: widget.textController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.red[50],
                      contentPadding: const EdgeInsets.all(12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Colors.red[100] ?? Colors.red),
                      ),
                    ),
                    style: TextStyle(fontSize: 14, color: Colors.red[400]),
                    validator: (widget.label == "Purchase Date")
                        ? (value) {
                            return _getValidationMessage(
                                value, widget.label, widget.selectedCategory);
                          }
                        : null,
                  ),
                )
              : TextFormField(
                  controller: widget.textController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.red[50],
                    contentPadding: const EdgeInsets.all(12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.red[100] ?? Colors.red),
                    ),
                  ),
                  style: TextStyle(fontSize: 14, color: Colors.red[400]),
                  validator: (value) {
                    return _getValidationMessage(
                        value, widget.label, widget.selectedCategory);
                  },
                ),
        ],
      ),
    );
  }

  String? _getValidationMessage(String? value, String label, String category) {
    Map<String, List<String>> fields = {
      "Vehicle": [
        'invoice',
        'Serial Number',
        'Model',
        'Chase Number',
        'Controller',
        'Motor',
        'battery_number',
        'Charger',
        'Purchase Date',
        'Customer Name',
        'Phone Number',
        'Email id',
        'Address'
      ],
      "Battery": [
        'invoice',
        'Serial Number',
        'Remarks',
        'Model',
        'Purchase Date',
        'Customer Name',
        'Phone Number',
        'Email id',
        'Address'
      ],
      "Charger": [
        'invoice',
        'Serial Number',
        'Model',
        'Purchase Date',
        'Customer Name',
        'Phone Number',
        'Email id',
        'Address'
      ],
    };

    if (fields[category]?.contains(label) ?? false) {
      if (value == null || value.isEmpty) {
        return "${'please_enter_your'.tr} ${label.tr}";
      }

      if (label == "Email id" &&
          !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
        return 'Please enter a valid email address'.tr;
      }

      if (label == "Phone No" && !RegExp(r'^[0-9]{10}$').hasMatch(value)) {
        return 'Please enter a valid 10-digit phone number'.tr;
      }
    }

    return null;
  }
}
