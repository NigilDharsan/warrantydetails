import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

import '../Dashboard/controller/warranty_controller.dart';

class Warrantydetails extends StatefulWidget {
  const Warrantydetails({super.key});

  @override
  State<Warrantydetails> createState() => _WarrantydetailsState();
}

class _WarrantydetailsState extends State<Warrantydetails> {
  Map<String, dynamic> get data {
    return {
      "type": Get.find<WarrantyController>().warrantyData.type ?? "",
      "serial_number":
          Get.find<WarrantyController>().warrantyData.serialNumber ?? "",
      "model": Get.find<WarrantyController>().warrantyData.model ?? "",
      "chno": Get.find<WarrantyController>().warrantyData.chno ?? "",
      "customer_name":
          Get.find<WarrantyController>().warrantyData.customerName ?? "",
      "phone_number":
          Get.find<WarrantyController>().warrantyData.phoneNumber ?? ""
    };
  }

  bool _isDownloading = false;

  @override
  Widget build(BuildContext context) {
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
          },
        ),
        title: const Text(
          'Warranty Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: GetBuilder<WarrantyController>(
        builder: (controller) {
          return MainUI(context, controller);
        },
      ),
    );
  }

  Widget MainUI(
    BuildContext context,
    WarrantyController controller,
  ) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Dealer',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        Text('${controller.warrantyData.address}'),
                        const SizedBox(height: 10),
                        const Text(
                          'Customer',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        Text('${controller.warrantyData.customerName}'),
                        const SizedBox(height: 15),
                        Divider(color: Colors.grey),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Description',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Items',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(color: Colors.grey),
                        ...data.entries.map((entry) {
                          return Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      entry.key,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "${entry.value}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(color: Colors.grey),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        Positioned(
          top: 30,
          right: 50,
          child: Row(
            children: [
              IconButton(
                onPressed: _generateAndDownloadPDF,
                icon: const Icon(Icons.download, color: Colors.blue),
                tooltip: 'Download & Share PDF',
              ),
              IconButton(
                onPressed: () => _confirmDelete(context),
                icon: const Icon(Icons.delete, color: Colors.red),
                tooltip: 'Delete',
              ),
            ],
          ),
        ),
        if (_isDownloading)
          const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            ),
          ),
      ],
    );
  }

  Future<void> _generateAndDownloadPDF() async {
    setState(() {
      _isDownloading = true;
    });

    try {
      final pdf = pw.Document();
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'From: Raja Street, Coimbatore',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                    color: const PdfColor.fromInt(0xFF0000), // Red color
                  ),
                ),
                pw.SizedBox(height: 5),
                pw.Text(
                  'To: Gandhi Street, Chennai',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                    color: const PdfColor.fromInt(0xFF0000), // Red color
                  ),
                ),
                pw.SizedBox(height: 15),
                pw.Divider(color: const PdfColor(0.5, 0.5, 0.5)),
                pw.Container(
                  decoration: pw.BoxDecoration(
                    color: const PdfColor(0.9, 0.9, 0.9),
                    borderRadius: pw.BorderRadius.circular(5),
                  ),
                  padding: const pw.EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 10,
                  ),
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(
                          'Description',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 14,
                            color: const PdfColor(0, 0, 0),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(
                          'Items',
                          style: pw.TextStyle(
                            fontSize: 14,
                            color: const PdfColor(0, 0, 0),
                          ),
                          textAlign: pw.TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
                pw.Text('Warranty Details', style: pw.TextStyle(fontSize: 18)),
                pw.SizedBox(height: 15),
                ...data.entries.map((entry) {
                  return pw.Row(
                    children: [
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(
                          entry.key,
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 14),
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(
                          "${entry.value}",
                          style: pw.TextStyle(
                              fontSize: 14,
                              color: const PdfColor(0.5, 0.5, 0.5)),
                          textAlign: pw.TextAlign.left,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ],
            );
          },
        ),
      );

      final output = await getExternalStorageDirectory();
      final filePath = '${output!.path}/warranty_details.pdf';
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      await Share.shareXFiles([XFile(filePath)],
          text: 'Warranty details PDF is attached.');
      _showSnackbar('PDF downloaded and shared successfully!');
    } catch (e) {
      _showSnackbar('Error generating PDF: $e');
    } finally {
      setState(() {
        _isDownloading = false;
      });
    }
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Confirmation'),
        content: const Text('Are you sure you want to delete this Details?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await Get.find<WarrantyController>().deleteWarrantyData(
                  Get.find<WarrantyController>().warrantyData.id ?? 0);

              if (Get.find<WarrantyController>().successModelData?.status ==
                  'True') {
                Get.find<WarrantyController>().getWarrantyData("", 1, 10);
                _showSnackbar('Warranty Details deleted successfully!');

                Get.back();
              } else {}
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), duration: const Duration(seconds: 3)));
  }
}
