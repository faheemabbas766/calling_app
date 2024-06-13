
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'call_details_view.dart';

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
    return todayCalls.length + yesterdayCalls.length + lastWeekCalls.length + 3; // +3 for the date sections
  }
}