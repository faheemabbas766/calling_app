import 'package:flutter/material.dart';
class CallDetailsScreen extends StatefulWidget {
  const CallDetailsScreen({Key? key}) : super(key: key);

  @override
  State<CallDetailsScreen> createState() => _CallDetailsScreenState();
}

class _CallDetailsScreenState extends State<CallDetailsScreen> {
  static const Color color344E5F = Color(0xFF344E5F);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: color344E5F),
          onPressed: () {
            // Handle back button
          },
        ),
        centerTitle: true,
        title: const Text(
          'Calls History',
          style: TextStyle(color: color344E5F),
        ),
        actions: const [Text("Settings   ")],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 25),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xFF27A5DD),
                  radius: 50,
                  child: Icon(Icons.person, size: 50, color: Colors.white,),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text("Dr. Kevin Jones", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color344E5F)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text("+1 (234) 5678 9012", style: TextStyle(fontSize: 14, color: color344E5F)),
                ),
                Padding(padding: EdgeInsets.only(top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(0xFF27A5DD),
                      radius: 20,
                      child: Icon(Icons.call, size: 20, color: Colors.white,),
                    ),
                    SizedBox(width: 20,),
                    CircleAvatar(
                      backgroundColor: Color(0xFF82C440),
                      radius: 20,
                      child: Icon(Icons.message, size: 20, color: Colors.white,),
                    ),
                  ],
                ),)
              ],
            ),
          ),

          Expanded(
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Today", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color344E5F)),
                            Text("Monday, January 22nd 2024", style: TextStyle(fontSize: 14, color: color344E5F)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                _buildCallItem('Missed Call', '09:20 AM', Colors.orange),
                _buildCallItem('Incoming Call', '09:20 AM', Colors.green),
                _buildCallItem('Outgoing Call', '09:20 AM', Color(0xFF27A5DD)),
                _buildDateSection('Yesterday', 'Sunday, January 21st 2024'),
                _buildCallItem( 'Missed Call', '09:20 AM', Colors.orange),
                _buildCallItem('Outgoing Call', '09:20 AM', Color(0xFF27A5DD)),
                _buildDateSection('Last Week', 'Sunday, January 22nd 2024'),
                _buildCallItem( 'Missed Call', '09:20 AM', Colors.orange),
                _buildCallItem('Outgoing Call', '09:20 AM', Color(0xFF27A5DD)),
                _buildCallItem('Missed Call', '09:20 AM', Colors.orange),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isSelected, VoidCallback onPressed) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
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
                color: isSelected ? Colors.white : color344E5F,
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
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color344E5F)),
          Text(subtitle, style: const TextStyle(fontSize: 14, color: color344E5F)),
        ],
      ),
    );
  }

  Widget _buildCallItem(String type, String time,Color color) {
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
            children: [ // Adjust the width as needed for spacing between time and name
              Text(type, style: const TextStyle(color: color344E5F)),
              const SizedBox(width: 8.0),
              Text(time, style: const TextStyle(fontSize: 10),),
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
