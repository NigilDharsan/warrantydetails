import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Warrantyregistration extends StatefulWidget {
  const Warrantyregistration({super.key});

  @override
  State<Warrantyregistration> createState() => _WarrantyregistrationState();
}

class _WarrantyregistrationState extends State<Warrantyregistration> {
  final Map<String, TextEditingController> _controllers = {
    'S.no': TextEditingController(text: '1'),
    'Model': TextEditingController(text: 'XYZ123'),
    'CHNO': TextEditingController(text: 'CH-4567'),
    'Motor': TextEditingController(text: 'Motor123'),
    'Controller': TextEditingController(text: 'Ctrl-7890'),
    'Charger': TextEditingController(text: 'Fast Charge'),
    'Battery.No': TextEditingController(text: 'BAT-1122'),
    'Customer Name': TextEditingController(text: 'Raja'),
    'Address': TextEditingController(text: '123 Main Street'),
    'Phone No': TextEditingController(text: '+91-9876543210'),
    'Purchase Date': TextEditingController(text: '2025-01-16'),
  };

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print('build:$build');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
            print('dashboard:$Get');
          },
        ),
        title: const Text(
          'Warranty Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Arial',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var entry in _controllers.entries)
                _buildEditableRow(entry.key, entry.value),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          print("Form Data:");
                          for (var entry in _controllers.entries) {
                            print("${entry.key}: ${entry.value.text}");
                          }
                        },
                        elevation: 2,
                        child: Text(
                          "Submit",
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
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
            style: TextStyle(
              fontSize: 14,
              color: Colors.red[300],
              fontWeight: FontWeight.bold, // Optional for emphasis
            ),
          ),
          const SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
              color: Colors.red[50], // Background color
              borderRadius: BorderRadius.circular(10), // Rounded corners
              border: Border.all(
                color: Colors.red[100] ?? Colors.red, // Subtle sad red color
                width: 0.5, // Thinner border
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12, // Subtle shadow color
                  blurRadius: 2, // Reduced blur for a softer shadow
                  offset: const Offset(0, 1), // Lighter shadow position
                ),
              ],
            ),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(12),
                border: InputBorder.none, // Removes default border
              ),
              style: TextStyle(
                fontSize: 14,
                color: Colors.red[200],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
