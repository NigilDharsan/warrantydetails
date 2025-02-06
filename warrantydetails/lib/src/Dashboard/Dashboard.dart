import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warrantydetails/src/Dashboard/controller/warranty_controller.dart';
import 'package:warrantydetails/src/Dashboard/widget/warrantyListItem.dart';
import 'package:warrantydetails/src/Login/loginScreen.dart';
import 'package:warrantydetails/src/WarrantyDetails/warrantyDetails.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<String> _items = [
    // 'Vehicle',
    // 'Auto',
    // 'Car',
    // 'Bike',
    // 'Travels',
  ];

  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = _items; // Initially show all items.
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
    setState(() {
      if (query.isEmpty) {
        _filteredItems = _items; // Show all items if search is empty.
      } else {
        _filteredItems = _items
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
        _filteredItems.sort(); // Sort alphabetically.
      }
    });
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
                .getWarrantyData(), // Called when the controller is initialized
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

            ListView.builder(
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
