import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warrantydetails/src/Dashboard/controller/warranty_controller.dart';
import 'package:warrantydetails/src/Dashboard/widget/warrantyListItem.dart';
import 'package:warrantydetails/src/Login/loginScreen.dart';
import 'package:warrantydetails/src/WarrantyDetails/warrantyDetails.dart';
import 'package:warrantydetails/utils/images.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredItems = [];

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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Loginscreen()),
        );
        return false;
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
        ),
        body: GetBuilder<WarrantyController>(
            initState: (state) => Get.find<WarrantyController>()
                .getWarrantyData(
                    "", 1, 10), // Called when the controller is initialized
            builder: (controller) {
              return MainUI(context, controller);
            }),
      ),
    );
  }

  MainUI(context, controller) {
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
                  onPressed: () {
                    print("Filter icon clicked");
                  },
                ),
              ],
            ),

            controller.warrantyListData?.data?.length == 0
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Image.asset(
                      Images.noDataFound, // Replace with your image asset path
                      width: 200.0, // Set the width of the image
                      height: 200.0, // Set the height of the image
                    ),
                  )
                : ListView.builder(
                    shrinkWrap:
                        true, // Allows ListView to size itself based on content
                    physics:
                        const NeverScrollableScrollPhysics(), // Prevents nested scrolling
                    itemCount: controller.warrantyListData?.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          controller.warrantyData =
                              controller.warrantyListData?.data?[index];
                          controller.update();
                          Get.to(() => const Warrantydetails());
                        },
                        child: warrantyListItems(
                            controller.warrantyListData!.data![index]),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
