import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CallItem {
  final String name;
  final String type;
  final String time;
  final DateTime date;
  final bool active;
  final bool isIncoming;

  CallItem(this.name, this.type, this.time, this.date, this.active, this.isIncoming);
}
class CallBlendedListController extends GetxController {
  RxBool isIncomingSelected = true.obs;
  RxList<CallItem> callItems = RxList<CallItem>();
  RxList<CallItem> todayCalls = RxList<CallItem>();
  RxList<CallItem> yesterdayCalls = RxList<CallItem>();
  RxList<CallItem> lastWeekCalls = RxList<CallItem>();
  TextEditingController incomingController = TextEditingController();
  TextEditingController outgoingController = TextEditingController();
  FocusNode textFieldFocusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    callItems.assignAll([
      CallItem('+1 (234) 567 8901 (2)', 'Missed Call', '09:20 AM', DateTime.now(), true, true),
      CallItem('Dr. Kevin Jones (6)', 'Incoming Call', '09:20 AM', DateTime.now(), false, true),
      CallItem('+1 (234) 567 8901 (2)', 'Missed Call', '09:20 AM', DateTime.now(), true, true),
      CallItem('Dr. Kevin Jones (6)', 'Incoming Call', '09:20 AM', DateTime.now(), false, true),
      CallItem('+1 (234) 567 8901 (2)', 'Missed Call', '09:20 AM', DateTime.now(), false, false),
      CallItem('+1 (234) 567 8901 (8)', 'Missed Call', '09:20 AM', DateTime.now(), false, false),
      CallItem('+1 (234) 567 8901', 'Missed Call', '09:20 AM', DateTime.now().subtract(const Duration(days: 1)), true, true),
      CallItem('+1 (234) 567 8901', 'Missed Call', '09:20 AM', DateTime.now().subtract(const Duration(days: 1)), true, true),
      CallItem('+1 (234) 567 8901 (3)', 'Missed Call', '10:30 AM', DateTime.now().subtract(const Duration(days: 2)), false, false),
      CallItem('Alice Smith', 'Outgoing Call', '11:15 AM', DateTime.now().subtract(const Duration(days: 2)), false, false),
      CallItem('+1 (555) 678 1234', 'Incoming Call', '01:45 PM', DateTime.now().subtract(const Duration(days: 3)), true, true),
      CallItem('Bob Johnson', 'Missed Call', '03:50 PM', DateTime.now().subtract(const Duration(days: 3)), false, false),
      CallItem('+1 (222) 333 4444', 'Incoming Call', '05:20 PM', DateTime.now().subtract(const Duration(days: 4)), true, true),
      CallItem('Charlie Brown', 'Outgoing Call', '07:10 PM', DateTime.now().subtract(const Duration(days: 4)), false, false),
      CallItem('+1 (111) 222 3333', 'Missed Call', '08:30 PM', DateTime.now().subtract(const Duration(days: 5)), true, true),
      CallItem('David Wilson', 'Incoming Call', '09:50 PM', DateTime.now().subtract(const Duration(days: 5)), false, true),
      CallItem('+1 (444) 555 6666', 'Missed Call', '11:20 PM', DateTime.now().subtract(const Duration(days: 6)), true, true),
      CallItem('Eve Adams', 'Outgoing Call', '12:30 AM', DateTime.now().subtract(const Duration(days: 6)), false, false),
      CallItem('+1 (777) 888 9999', 'Incoming Call', '02:15 AM', DateTime.now().subtract(const Duration(days: 7)), true, true),
      CallItem('Frank Miller', 'Missed Call', '04:05 AM', DateTime.now().subtract(const Duration(days: 7)), false, false),
      CallItem('+1 (888) 777 6666', 'Outgoing Call', '05:50 AM', DateTime.now().subtract(const Duration(days: 8)), true, false),
      CallItem('Grace Lee', 'Incoming Call', '07:30 AM', DateTime.now().subtract(const Duration(days: 8)), false, true),
    ]);
    filterItems('');
  }

  void filterItems(String query) {
    final filteredItems = callItems.where((item) =>
    item.name.toLowerCase().contains(isIncomingSelected.value
        ? incomingController.text.toLowerCase()
        : outgoingController.text.toLowerCase()) &&
        _isCategorySelected(item)).toList();

    todayCalls.assignAll(filteredItems
        .where((item) => _isSameDay(item.date, DateTime.now()))
        .toList());
    yesterdayCalls.assignAll(filteredItems
        .where((item) =>
        _isSameDay(item.date, DateTime.now().subtract(const Duration(days: 1))))
        .toList());
    lastWeekCalls.assignAll(filteredItems
        .where((item) =>
    item.date.isAfter(DateTime.now().subtract(const Duration(days: 7))) &&
        !_isSameDay(item.date, DateTime.now()) &&
        !_isSameDay(item.date, DateTime.now().subtract(const Duration(days: 1))))
        .toList());
  }

  bool _isCategorySelected(CallItem item) {
    return isIncomingSelected.value ? item.isIncoming : !item.isIncoming;
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  void toggleSelected(bool incomingSelected) {
    isIncomingSelected.value = incomingSelected;
    filterItems(incomingSelected ? incomingController.text : outgoingController.text);
  }

  int calculateItemCount() {
    int itemCount = 0;
    if (todayCalls.isNotEmpty) itemCount += todayCalls.length;
    if (yesterdayCalls.isNotEmpty) itemCount += yesterdayCalls.length;
    if (lastWeekCalls.isNotEmpty) itemCount += lastWeekCalls.length;
    return itemCount;
  }
}