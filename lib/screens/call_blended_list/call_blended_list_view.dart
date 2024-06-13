import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../Theme/theme.dart';
import '../call_details/call_details_view.dart';
import 'call_blended_list_view_model.dart';
class CallBlendedListScreen extends StatelessWidget {
  CallBlendedListScreen({Key? key}) : super(key: key);
  final CallBlendedListController controller = Get.put(CallBlendedListController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Obx(
          () => Scaffold(
        backgroundColor: Get.find<ThemeController>().isDarkMode.value ? const Color(0xFF344E5F) : Colors.white,
        appBar: AppBar(
          backgroundColor: Get.find<ThemeController>().isDarkMode.value ? const Color(0xFF344E5F) : Colors.white,
          centerTitle: true,
          title: Text(
            'Calls',
            style: TextStyle(color: Get.find<ThemeController>().isDarkMode.value ? Colors.white : const Color(0xFF344E5F)),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: 25),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE8EBEE),
                  borderRadius: BorderRadius.circular(37.0),
                ),
                child: Obx(
                      () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildToggleButton('Incoming', controller.isIncomingSelected.value),
                      _buildToggleButton('Outgoing', !controller.isIncomingSelected.value),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: 8.0),
              child: SizedBox(
                height: 50,
                width: screenWidth * 0.9,
                child: TextField(
                  onTapOutside: (event) {
                    controller.textFieldFocusNode.unfocus();
                  },
                  focusNode: controller.textFieldFocusNode,
                  controller: controller.isIncomingSelected.value ? controller.incomingController : controller.outgoingController,
                  onChanged: (query) => controller.filterItems(query),
                  decoration: InputDecoration(
                    hintText: '  Search',
                    hintStyle: TextStyle(
                        color: Get.find<ThemeController>().isDarkMode.value ? Colors.white : const Color(0xFF344E5F)
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24.0),
                      borderSide: BorderSide(
                        color: Get.find<ThemeController>().isDarkMode.value ? Colors.white : const Color(0xFF344E5F).withOpacity(0.5),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: BorderSide(
                        color: Get.find<ThemeController>().isDarkMode.value ? Colors.white : const Color(0xFF344E5F).withOpacity(0.5),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: BorderSide(
                        color: Get.find<ThemeController>().isDarkMode.value ? Colors.white : const Color(0xFF344E5F),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            controller.calculateItemCount() == 0
                ? Center(
              child: Text(
                'No records found',
                style: TextStyle(
                    color:
                    Get.find<ThemeController>().isDarkMode.value ? Colors.white : const Color(0xFF344E5F).withOpacity(0.5),
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
                : Expanded(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverPadding(
                    padding: const EdgeInsets.only(bottom: 80.0), // Adjust the value to match the FAB size
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          if (index == 0 && controller.todayCalls.isNotEmpty) {
                            return _buildDateSection('Today', 'Monday, January 22nd 2024');
                          } else if (index == controller.todayCalls.length + 1 && controller.yesterdayCalls.isNotEmpty) {
                            return _buildDateSection('Yesterday', 'Sunday, January 21st 2024');
                          } else if (index == controller.todayCalls.length + controller.yesterdayCalls.length + 2 && controller.lastWeekCalls.isNotEmpty) {
                            return _buildDateSection('Last Week', 'January 15th - January 21st 2024');
                          } else {
                            int adjustedIndex = index;
                            if (controller.todayCalls.isNotEmpty) adjustedIndex--;
                            if (adjustedIndex >= controller.todayCalls.length + 1 && controller.yesterdayCalls.isNotEmpty) adjustedIndex--;
                            if (adjustedIndex >= controller.todayCalls.length + controller.yesterdayCalls.length + 2 && controller.lastWeekCalls.isNotEmpty) adjustedIndex--;

                            CallItem call;
                            if (adjustedIndex < controller.todayCalls.length) {
                              call = controller.todayCalls[adjustedIndex];
                            } else if (adjustedIndex < controller.todayCalls.length + controller.yesterdayCalls.length) {
                              call = controller.yesterdayCalls[adjustedIndex - controller.todayCalls.length];
                            } else {
                              call = controller.lastWeekCalls[
                              adjustedIndex -
                                  controller.todayCalls.length -
                                  controller.yesterdayCalls.length];
                            }
                            return _buildCallItem(call.name, call.type, call.time, call.active);
                          }
                        },
                        childCount: controller.calculateItemCount(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: ClipOval(
          child: Container(
            width: 65.0,
            height: 65.0,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF26A1DB), // Start color
                  Color(0xFF107CAF), // End color
                ],
              ),
            ),
            child: IconButton(
              onPressed: () {
                Get.find<ThemeController>().toggleDarkMode();
                bool isDarkMode = Get.find<ThemeController>().isDarkMode.value;
                print(isDarkMode ? "Dark" : "Light");
              },
              icon: const Icon(Icons.add, size: 50),
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.toggleSelected(text == 'Incoming'),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF27A5DD) : Colors.transparent,
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF344E5F),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateSection(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Get.find<ThemeController>().isDarkMode.value ? Colors.white : const Color(0xFF344E5F))),
          Text(subtitle, style: TextStyle(fontSize: 14, color: Get.find<ThemeController>().isDarkMode.value ? Colors.white : const Color(0xFF344E5F))),
        ],
      ),
    );
  }

  Widget _buildCallItem(String name, String type, String time, bool active) {
    return InkWell(
      onTap: () {
        Get.to(() => CallDetailsScreen());
      },
      child: Column(
        children: [
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: const Icon(Icons.phone_iphone, color: Colors.white),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 195, child: Text(name, style: TextStyle(fontWeight: FontWeight.bold, color: Get.find<ThemeController>().isDarkMode.value ? Colors.white : const Color(0xFF344E5F)))),
                const SizedBox(width: 8.0),
                Text(time, style: TextStyle(fontSize: 10,color: Get.find<ThemeController>().isDarkMode.value ? Colors.white : Color(0xFF344E5F))),
                const SizedBox(width: 5),
                active ? const Icon(Icons.circle, color: Color(0xFF27A5DD), size: 8.0) : const Icon(Icons.circle, color: Colors.transparent, size: 8.0),
              ],
            ),
            subtitle: Text(type, style: TextStyle(color: Get.find<ThemeController>().isDarkMode.value ? Colors.white : const Color(0xFF344E5F)),),
          ),
          Divider(
            height: 1.0,
            indent: 72,
            color: Colors.grey[300], // Adjust the color as needed
          ),
        ],
      ),
    );
  }
}
