import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme.dart';

class CallDetailsController extends GetxController {
  var todayCalls = <CallItemDetails>[].obs;
  var yesterdayCalls = <CallItemDetails>[].obs;
  var lastWeekCalls = <CallItemDetails>[].obs;

  void fetchCallHistory() {
    todayCalls.addAll([
      CallItemDetails('Missed Call', '09:20 AM', Colors.orange),
      CallItemDetails('Incoming Call', '09:20 AM', Colors.green),
    ]);

    yesterdayCalls.addAll([
      CallItemDetails('Outgoing Call', '09:20 AM', const Color(0xFF27A5DD)),
    ]);

    lastWeekCalls.addAll([
      CallItemDetails('Missed Call', '09:20 AM', Colors.orange),
      CallItemDetails('Outgoing Call', '09:20 AM', const Color(0xFF27A5DD)),
      CallItemDetails('Missed Call', '09:20 AM', Colors.orange),
    ]);
  }

  int calculateItemCount() {
    int itemCount = 0;
    if (todayCalls.isNotEmpty) itemCount += todayCalls.length ;
    if (yesterdayCalls.isNotEmpty) itemCount += yesterdayCalls.length;
    if (lastWeekCalls.isNotEmpty) itemCount += lastWeekCalls.length;
    return itemCount;
  }
}

// Main widget for call details screen
class CallDetailsScreen extends StatelessWidget {
  final CallDetailsController controller = Get.put(CallDetailsController());

  CallDetailsScreen({Key? key}) : super(key: key);

  static const Color color344E5F = Color(0xFF344E5F);

  @override
  Widget build(BuildContext context) {
    // Fetch call history when the widget is first built
    controller.fetchCallHistory();

    return Scaffold(
      backgroundColor: Get.find<ThemeController>().isDarkMode.value ? const Color(0xFF344E5F) : Colors.white,
      appBar: AppBar(
        backgroundColor: Get.find<ThemeController>().isDarkMode.value ? const Color(0xFF344E5F) : Colors.white,
        centerTitle: true,
        title: Obx(() =>
            Text(
              'Calls History',
              style: TextStyle(color: Get.find<ThemeController>().isDarkMode.value ? Colors.white : color344E5F),
            )),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Center(
                child: Text("Settings", style: TextStyle(color: Colors.blue))),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: Column(
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFF27A5DD),
                  radius: 50,
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
                const SizedBox(height: 20),
                Obx(() =>
                    Text(
                      "Dr. Kevin Jones",
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold, color: Get.find<ThemeController>().isDarkMode.value ? Colors.white : color344E5F),
                    )),
                const SizedBox(height: 10),
                Obx(() =>
                    Text(
                      "+1 (234) 5678 9012",
                      style: TextStyle(fontSize: 14, color: Get.find<ThemeController>().isDarkMode.value ? Colors.white : color344E5F),
                    )),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(0xFF27A5DD),
                      radius: 20,
                      child: Icon(Icons.call, size: 20, color: Colors.white),
                    ),
                    SizedBox(width: 20),
                    CircleAvatar(
                      backgroundColor: Color(0xFF82C440),
                      radius: 20,
                      child: Icon(Icons.message, size: 20, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() =>
                ListView.builder(
                  padding: const EdgeInsets.only(bottom: 80.0),
                  itemCount: controller.calculateItemCount(),
                  itemBuilder: (context, index) {
                    if (controller.todayCalls.isNotEmpty && index == 0) {
                      return _buildDateSection(
                          'Today', 'Monday, January 22nd 2024');
                    } else if (controller.yesterdayCalls.isNotEmpty &&
                        index == controller.todayCalls.length + 1) {
                      return _buildDateSection(
                          'Yesterday', 'Sunday, January 21st 2024');
                    } else if (controller.lastWeekCalls.isNotEmpty && index ==
                        controller.todayCalls.length +
                            controller.yesterdayCalls.length + 2) {
                      return _buildDateSection(
                          'Last Week', 'January 15th - January 21st 2024');
                    } else {
                      int adjustedIndex = index;
                      if (controller.todayCalls.isNotEmpty &&
                          adjustedIndex > 0) adjustedIndex--;
                      if (controller.yesterdayCalls.isNotEmpty &&
                          adjustedIndex >
                              controller.todayCalls.length) adjustedIndex--;
                      if (controller.lastWeekCalls.isNotEmpty && adjustedIndex >
                          controller.todayCalls.length +
                              controller.yesterdayCalls.length) adjustedIndex--;

                      CallItemDetails call;
                      if (adjustedIndex < controller.todayCalls.length) {
                        call = controller.todayCalls[adjustedIndex];
                      } else if (adjustedIndex < controller.todayCalls.length +
                          controller.yesterdayCalls.length) {
                        call = controller.yesterdayCalls[adjustedIndex -
                            controller.todayCalls.length];
                      } else {
                        call = controller.lastWeekCalls[adjustedIndex -
                            controller.todayCalls.length -
                            controller.yesterdayCalls.length];
                      }

                      return _buildCallItemDetails(
                          call.type, call.time, call.color);
                    }
                  },
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSection(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() =>
              Text(
                title,
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: Get.find<ThemeController>().isDarkMode.value ? Colors.white : color344E5F),
              )),
          Obx(() =>
              Text(
                subtitle,
                style: TextStyle(fontSize: 14, color: Get.find<ThemeController>().isDarkMode.value ? Colors.white : color344E5F),
              )),
        ],
      ),
    );
  }

  Widget _buildCallItemDetails(String type, String time, Color color) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: const Icon(Icons.phone_iphone, color: Colors.white),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() =>
                  Text(type, style: TextStyle(color: Get.find<ThemeController>().isDarkMode.value ? Colors.white : color344E5F))),
              const SizedBox(width: 8.0),
              Obx(() =>
                  Text(time, style: TextStyle(fontSize: 10, color: Get.find<ThemeController>().isDarkMode.value ? Colors.white : color344E5F))),
            ],
          ),
        ),
        Divider(
          height: 1.0,
          indent: 72,
          color: Colors.grey[300], // Adjust the color as needed
        ),
      ],
    );
  }
}
class CallItemDetails {
  String type;
  String time;
  Color color;

  CallItemDetails(this.type, this.time, this.color);
}
