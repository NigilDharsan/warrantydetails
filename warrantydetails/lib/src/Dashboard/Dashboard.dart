import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warrantydetails/src/Dashboard/Model/WarrantyListModel.dart';
import 'package:warrantydetails/src/Dashboard/controller/warranty_controller.dart';
import 'package:warrantydetails/src/Dashboard/widget/warrantyListItem.dart';
import 'package:warrantydetails/src/WarrantyDetails/warrantyDetails.dart';

class Dashboard extends StatefulWidget {
  static const routeName = '/dash';
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool warningShown = false;
  DateTime timeBackPressed = DateTime.now();
  bool _isDownloading = false;
  bool _isLoadingMore = false; // Track pagination loading
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _scrollController.addListener(_onScroll); // Add scroll listener
    Get.find<WarrantyController>().getWarrantyData("", _currentPage, 10);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim();
    _currentPage = 1; // Reset page number
    Get.find<WarrantyController>().getWarrantyData(query, _currentPage, 10);
  }

  // **Detect Scroll End and Load More Data**
  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoadingMore &&
        Get.find<WarrantyController>().hasMoreItems) {
      _loadMoreData();
    }
  }

  Future<void> _loadMoreData() async {
    setState(() {
      _isLoadingMore = true;
    });

    _currentPage++;
    await Get.find<WarrantyController>().getWarrantyData("", _currentPage, 10);

    setState(() {
      _isLoadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Center(
          child: Text(
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
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              // _showLogoutDialog();
            },
          ),
        ],
      ),
      body: GetBuilder<WarrantyController>(
        builder: (controller) {
          return MainUI(context, controller);
        },
      ),
    );
  }

  Widget MainUI(context, WarrantyController controller) {
    Map<String, List<WarrantyData>> groupedData = {};

    // **Group Data by Date**
    for (var item in controller.warrantyListData?.data ?? []) {
      DateTime createdDate = DateTime.parse(item.createdAt);
      String formattedDate = _formatDate(createdDate);

      if (!groupedData.containsKey(formattedDate)) {
        groupedData[formattedDate] = [];
      }
      groupedData[formattedDate]!.add(item);
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // **Search Bar**

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

          // **ListView with Pagination**
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: groupedData.keys.length + 1, // Add 1 for the loader
              itemBuilder: (context, index) {
                if (index == groupedData.keys.length) {
                  return _isLoadingMore
                      ? Center(child: CircularProgressIndicator())
                      : SizedBox(); // Empty when no more data
                }

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
          ),
        ],
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
