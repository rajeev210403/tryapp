import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0), // Add padding to the left and top of the home text
              child: Text(
                'Home',
                style: TextStyle(
                  fontSize: 30, // Adjust font size as needed
                  fontWeight: FontWeight.bold, // Make the text bold
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right:10.0,top: 10.0), // Add padding to the top of the search icon
              child: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // Add search functionality here
                },
              ),
            ), // Keep the search icon on the right
          ],
        ),
        actions: [],
        iconTheme: IconThemeData(color: Colors.black),
      ),

      bottomNavigationBar: const BottomNavigationBarWidget(),
      floatingActionButton: Container(
        width: 60.0, // Adjust the width as needed
        height: 60.0, // Adjust the height as needed
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green,
        ),
        child: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({Key? key}) : super(key: key);

  @override
  _BottomNavigationBarWidgetState createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _selectedIndex = 0;

  List<dynamic> _bottomNavItems = [];

  @override
  void initState() {
    super.initState();
    _loadBottomNavItems();
  }

  Future<void> _loadBottomNavItems() async {
    try {
      String data = await DefaultAssetBundle.of(context).loadString('assets/jsonfiles/bottom_bar.json');
      setState(() {
        _bottomNavItems = List<dynamic>.from(json.decode(data));
      });
    } catch (e) {
      print('Error loading JSON: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_bottomNavItems.length < 2) {
      return SizedBox.shrink(); // Return an empty widget if there are less than 2 items
    }
    return BottomAppBar(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ..._bottomNavItems.asMap().entries.take(2).map((entry) {
            int index = entry.key;
            dynamic item = entry.value;
            return Expanded(
              child: item['label'].isEmpty
                  ? _buildEmptyItem()
                  : _buildNavItem(index, item),
            );
          }).toList(),
          Expanded(child: Container()), // Middle space for FAB
          ..._bottomNavItems.asMap().entries.skip(2).map((entry) {
            int index = entry.key;
            dynamic item = entry.value;
            return Expanded(
              child: item['label'].isEmpty
                  ? _buildEmptyItem()
                  : _buildNavItem(index, item),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, dynamic item) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index; // Update the selected index
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getIcon(item['icon']),
            color: _selectedIndex == index ? Colors.green : Color.fromRGBO(66, 75, 84, 0.6),
            size: 28,
          ),
          Text(
            item['label'],
            style: TextStyle(
              fontSize: 12,
              color: _selectedIndex == index ? Colors.green : Color.fromRGBO(66, 75, 84, 0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyItem() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.circle,
          color: Colors.white,
          size: 28,
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  IconData _getIcon(String? iconString) {
    if (iconString == null || iconString.isEmpty) {
      return Icons.circle;
    }
    int code = int.tryParse(iconString.substring(2), radix: 16) ?? 0xe88a;
    return IconData(code, fontFamily: 'MaterialIcons');
  }
}
