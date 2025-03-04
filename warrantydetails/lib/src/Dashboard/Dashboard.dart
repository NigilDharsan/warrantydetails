import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warrantydetails/src/Dashboard/Model/WarrantyListModel.dart';
import 'package:warrantydetails/src/Dashboard/controller/warranty_controller.dart';
import 'package:warrantydetails/src/Dashboard/widget/warrantyListItem.dart';
import 'package:warrantydetails/src/Login/loginScreen.dart';
import 'package:warrantydetails/src/Login/warrantyRegistration.dart';
import 'package:warrantydetails/src/WarrantyDetails/warrantyDetails.dart';
import 'package:warrantydetails/utils/Language/Language.dart';
import 'package:warrantydetails/utils/images.dart';

class Dashboard extends StatefulWidget {
  static const routeName = '/dash';
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final TextEditingController _searchController = TextEditingController();
  bool warningShown = false;
  DateTime timeBackPressed = DateTime.now();
  bool _isDownloading = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim();
    Get.find<WarrantyController>().getWarrantyData(query, 1, 10);
  }

  void _showLogoutDialog() {
    Get.defaultDialog(
      title: "Logout",
      middleText: "Are you sure you want to logout?",
      textCancel: "Cancel",
      textConfirm: "OK",
      onConfirm: () {
        loggedStatus(false);
        Get.offAll(() => const Loginscreen()); // Navigate to Login
        print("User Logged Out");
      },
      onCancel: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        if (_isDownloading) {
          const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            ),
          );
        }
        ; // Your refresh logic here
      },
      child: WillPopScope(
        onWillPop: () async {
          final difference = DateTime.now().difference(timeBackPressed);
          final isExitWarning = difference >= Duration(seconds: 2);
          timeBackPressed = DateTime.now();
          if (isExitWarning) {
            warningShown = false;
          }
          if (!warningShown) {
            warningShown = true;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Press back again to exit'),
              ),
            );
            return false;
          }
          return true;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: Center(
              child: const Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: () {
                  _showLogoutDialog();
                },
              ),
            ],
          ),
          floatingActionButton: new FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () async {
              var result = await Get.to(Warrantyregistration());

              if (result == true) {
                Get.find<WarrantyController>().getWarrantyData("", 1, 10);
              }
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndFloat,
          body: GetBuilder<WarrantyController>(
              initState: (state) => Get.find<WarrantyController>()
                  .getWarrantyData(
                      "", 1, 10), // Called when the controller is initialized
              builder: (controller) {
                return MainUI(context, controller);
              }),
        ),
      ),
    );
  }

  MainUI(context, controller) {
    Map<String, List<WarrantyData>> groupedData = {};

    // Group data by date
    for (var item in controller.warrantyListData?.data ?? []) {
      DateTime createdDate = DateTime.parse(item.createdAt);
      String formattedDate = _formatDate(createdDate);

      if (!groupedData.containsKey(formattedDate)) {
        groupedData[formattedDate] = [];
      }
      groupedData[formattedDate]!.add(item);
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search Bar Row
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search for items...",
                      hintStyle: const TextStyle(color: Colors.redAccent),
                      prefixIcon:
                          const Icon(Icons.search, color: Colors.redAccent),
                      filled: true,
                      fillColor: Colors.red[50],
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.filter_list, color: Colors.redAccent),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Display grouped lists
            controller.warrantyListData?.data?.isEmpty ?? true
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Image.asset(
                      Images.noDataFound,
                      width: 200.0,
                      height: 200.0,
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: groupedData.keys.length,
                    itemBuilder: (context, index) {
                      String date = groupedData.keys.elementAt(index);
                      List<WarrantyData> items = groupedData[date]!;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              date,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          ...items.map((item) {
                            return GestureDetector(
                              onTap: () {
                                controller.warrantyData = item;
                                controller.update();
                                Get.to(() => const Warrantydetails());
                              },
                              child: warrantyListItems(item),
                            );
                          }).toList(),
                        ],
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}

// Helper function to format dates
String _formatDate(DateTime date) {
  DateTime now = DateTime.now();
  DateTime yesterday = now.subtract(Duration(days: 1));

  if (DateFormat('yyyy-MM-dd').format(date) ==
      DateFormat('yyyy-MM-dd').format(now)) {
    return "Today";
  } else if (DateFormat('yyyy-MM-dd').format(date) ==
      DateFormat('yyyy-MM-dd').format(yesterday)) {
    return "Yesterday";
  } else {
    return DateFormat('dd MMM yyyy').format(date);
  }
}
