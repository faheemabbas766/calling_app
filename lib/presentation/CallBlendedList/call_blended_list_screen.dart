import 'package:flutter/material.dart';
import 'package:calling_app/presentation/CallBlendedList/call_details_screen.dart';

class CallBlendedListScreen extends StatefulWidget {
  const CallBlendedListScreen({Key? key}) : super(key: key);

  @override
  State<CallBlendedListScreen> createState() => _CallBlendedListScreenState();
}

class _CallBlendedListScreenState extends State<CallBlendedListScreen> {
  bool _isIncomingSelected = true;
  static const Color color344E5F = Color(0xFF344E5F);

  final List<CallItem> _callItems = [
    CallItem('+1 (234) 567 8901 (2)', 'Missed Call', '09:20 AM', DateTime.now(), true),
    CallItem('Dr. Kevin Jones (6)', 'Incoming Call', '09:20 AM', DateTime.now(), false),
    CallItem('+1 (234) 567 8901 (2)', 'Missed Call', '09:20 AM', DateTime.now(), false),
    CallItem('+1 (234) 567 8901 (8)', 'Missed Call', '09:20 AM', DateTime.now(), false),
    CallItem('+1 (234) 567 8901', 'Missed Call', '09:20 AM', DateTime.now().subtract(Duration(days: 1)), true),
    CallItem('+1 (234) 567 8901', 'Missed Call', '09:20 AM', DateTime.now().subtract(Duration(days: 1)), true),
    CallItem('+1 (234) 567 8901 (3)', 'Missed Call', '10:30 AM', DateTime.now().subtract(Duration(days: 2)), false),
    CallItem('Alice Smith', 'Outgoing Call', '11:15 AM', DateTime.now().subtract(Duration(days: 2)), false),
    CallItem('+1 (555) 678 1234', 'Incoming Call', '01:45 PM', DateTime.now().subtract(Duration(days: 3)), true),
    CallItem('Bob Johnson', 'Missed Call', '03:50 PM', DateTime.now().subtract(Duration(days: 3)), false),
    CallItem('+1 (222) 333 4444', 'Incoming Call', '05:20 PM', DateTime.now().subtract(Duration(days: 4)), true),
    CallItem('Charlie Brown', 'Outgoing Call', '07:10 PM', DateTime.now().subtract(Duration(days: 4)), false),
    CallItem('+1 (111) 222 3333', 'Missed Call', '08:30 PM', DateTime.now().subtract(Duration(days: 5)), true),
    CallItem('David Wilson', 'Incoming Call', '09:50 PM', DateTime.now().subtract(Duration(days: 5)), false),
    CallItem('+1 (444) 555 6666', 'Missed Call', '11:20 PM', DateTime.now().subtract(Duration(days: 6)), true),
    CallItem('Eve Adams', 'Outgoing Call', '12:30 AM', DateTime.now().subtract(Duration(days: 6)), false),
    CallItem('+1 (777) 888 9999', 'Incoming Call', '02:15 AM', DateTime.now().subtract(Duration(days: 7)), true),
    CallItem('Frank Miller', 'Missed Call', '04:05 AM', DateTime.now().subtract(Duration(days: 7)), false),
    CallItem('+1 (888) 777 6666', 'Outgoing Call', '05:50 AM', DateTime.now().subtract(Duration(days: 8)), true),
    CallItem('Grace Lee', 'Incoming Call', '07:30 AM', DateTime.now().subtract(Duration(days: 8)), false),
  ];

  late List<CallItem> _todayCalls;
  late List<CallItem> _yesterdayCalls;
  late List<CallItem> _lastWeekCalls;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filterItems('');
  }

  void _filterItems(String query) {
    setState(() {
      _searchQuery = query;
      final filteredItems = _callItems
          .where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      _todayCalls = filteredItems
          .where((item) => _isSameDay(item.date, DateTime.now()))
          .toList();
      _yesterdayCalls = filteredItems
          .where((item) => _isSameDay(item.date, DateTime.now().subtract(const Duration(days: 1))))
          .toList();
      _lastWeekCalls = filteredItems
          .where((item) => item.date.isAfter(DateTime.now().subtract(Duration(days: 7))) &&
          !_isSameDay(item.date, DateTime.now()) &&
          !_isSameDay(item.date, DateTime.now().subtract(const Duration(days: 1))))
          .toList();
    });
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

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
          'Calls',
          style: TextStyle(color: color344E5F),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 25),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE8EBEE),
                borderRadius: BorderRadius.circular(37.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildToggleButton('Incoming', _isIncomingSelected, () {
                    setState(() {
                      _isIncomingSelected = true;
                    });
                  }),
                  _buildToggleButton('Outgoing', !_isIncomingSelected, () {
                    setState(() {
                      _isIncomingSelected = false;
                    });
                  }),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
            child: SizedBox(
              height: 50,
              width: 352,
              child: TextField(
                onChanged: _filterItems,
                decoration: InputDecoration(
                  hintText: '  Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide(
                      color: color344E5F.withOpacity(0.5),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                    borderSide: BorderSide(
                      color: color344E5F.withOpacity(0.5),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                    borderSide: const BorderSide(
                      color: color344E5F,
                    ),
                  ),
                ),
              ),
            ),
          ),

          _calculateItemCount() == 0
              ? const Center(
            child: Text(
              'No records found',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          )
              :Expanded(
            child: ListView.builder(
              itemCount: _calculateItemCount(),
              itemBuilder: (context, index) {
                if (_todayCalls.isNotEmpty && index == 0) {
                  return _buildDateSection('Today', 'Monday, January 22nd 2024');
                } else if (index <= _todayCalls.length) {
                  final call = _todayCalls[index - 1];
                  return _buildCallItem(call.name, call.type, call.time, call.active);
                } else if (_yesterdayCalls.isNotEmpty && index == _todayCalls.length + 1) {
                  return _buildDateSection('Yesterday', 'Sunday, January 21st 2024');
                } else if (index <= _todayCalls.length + _yesterdayCalls.length + 1) {
                  final call = _yesterdayCalls[index - _todayCalls.length - 2];
                  return _buildCallItem(call.name, call.type, call.time, call.active);
                } else if (_lastWeekCalls.isNotEmpty && index == _todayCalls.length + _yesterdayCalls.length + 2) {
                  return _buildDateSection('Last Week', 'January 15th - January 21st 2024');
                } else {
                  final call = _lastWeekCalls[index - _todayCalls.length - _yesterdayCalls.length - 3];
                  return _buildCallItem(call.name, call.type, call.time, call.active);
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: InkWell(
        onTap: () {},
        child: Container(
          width: 65.0,
          height: 65.0,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF26A1DB),
                Color(0xFF107CAF),
              ],
            ),
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 50),
        ),
      ),
    );
  }

  int _calculateItemCount() {
    int itemCount = 0;
    if (_todayCalls.isNotEmpty) itemCount += _todayCalls.length + 1;
    if (_yesterdayCalls.isNotEmpty) itemCount += _yesterdayCalls.length + 1;
    if (_lastWeekCalls.isNotEmpty) itemCount += _lastWeekCalls.length + 1;
    return itemCount;
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

  Widget _buildCallItem(String name, String type, String time, bool active) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CallDetailsScreen(),));
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
                SizedBox(
                    width: 195,
                    child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, color: color344E5F))),
                const SizedBox(width: 8.0),
                Text(time, style: const TextStyle(fontSize: 10),),
                SizedBox(width: 5,),
                active
                    ? const Icon(Icons.circle, color: Color(0xFF27A5DD), size: 8.0)
                    : const Icon(Icons.circle, color: Colors.transparent, size: 8.0)
              ],
            ),
            subtitle: Text(type),
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

class CallItem {
  final String name;
  final String type;
  final String time;
  final DateTime date;
  final bool active;

  CallItem(this.name, this.type, this.time, this.date, this.active);
}
