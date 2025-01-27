import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class Warrantydetails extends StatefulWidget {
  const Warrantydetails({super.key});

  @override
  State<Warrantydetails> createState() => _WarrantydetailsState();
}

class _WarrantydetailsState extends State<Warrantydetails> {
  final Map<String, String> details = {
    'S.NO': '1',
    'Model': 'XYZ123',
    'CH.No': 'CH-4567',
    'Motor': 'Motor123',
    'Controller': 'Con-3456',
    'Charge': 'Fast Charge',
    'Battery.No': 'BAT-1122',
    'Customer Name': 'Raja',
    'Address': '1/123, Raja Street',
    'Phone Number': '+91-9876543210',
  };

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
      body: Stack(
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
                          const Text('Raja Street, Coimbatore'),
                          const SizedBox(height: 10),
                          const Text(
                            'Customer',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          const Text('Gandhi Street, Chennai'),
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
                          ...details.entries.map((entry) {
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
                                        entry.value,
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
            top: 30, // Adjust this value as needed
            right: 50, // Adjust for horizontal positioning
            child: Row(
              // Use Row to position buttons side by side
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
              child: CircularProgressIndicator(),
            ),
        ],
      ),
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
                pw.Divider(),
                ...details.entries.map((entry) {
                  return pw.Column(
                    children: [
                      // pw.Row(
                      //   mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                      //   crossAxisAlignment: pw.CrossAxisAlignment.start,
                      //   children: [
                      //     pw.Text(
                      //       entry.key,
                      //       style: pw.TextStyle(
                      //         fontWeight: pw.FontWeight.bold,
                      //         fontSize: 12,
                      //       ),
                      //     ),
                      //     pw.Text(
                      //       entry.value,
                      //       style: pw.TextStyle(fontSize: 12),
                      //     ),
                      //   ],
                      // ),
                      pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Expanded(
                            flex: 2,
                            child: pw.Text(
                              entry.key,
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Text(
                              entry.value,
                              style: pw.TextStyle(
                                fontSize: 14,
                                color: const PdfColor.fromInt(
                                    0xFF666666), // Equivalent to black54
                              ),
                              textAlign: pw.TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                      pw.Divider(),
                    ],
                  );
                }).toList(),
              ],
            );
          },
        ),
      );

      final output = await getExternalStorageDirectory();
      final filePath = '${output!.path}/customer_details.pdf';
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      await Share.shareXFiles(
        [XFile(filePath)],
        text: 'Customer details PDF is attached.',
      );

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
        content: const Text('Are you sure you want to delete this content?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                details.clear();
              });
              _showSnackbar('Details deleted successfully!');
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
