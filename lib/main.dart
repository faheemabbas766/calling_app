import 'package:calling_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/call_blended_list/call_blended_list_view.dart';

void main() {
  Get.put(ThemeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: Get.find<ThemeController>().isDarkMode.value ? ThemeMode.dark : ThemeMode.light, // Access the isDarkMode from ThemeController
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: CallBlendedListScreen(),
    );
  }
}

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.to(() => CallBlendedListScreen());
          },
          child: const Text('Show Calling'),
        ),
      ),
    );
  }
}
