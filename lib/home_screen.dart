import 'package:flutter/material.dart';
import 'dart:convert';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // Add search functionality here
              },
            ),
          ),
        ],
        // debug
        backgroundColor: Colors.white, // Set the app bar background color to white
        iconTheme: const IconThemeData(color: Colors.black), // Set the app bar icon color to black
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Colors.green,
        elevation: 0,
        child: const Icon(Icons.add, color: Colors.white),
        shape: const CircleBorder(
          side: BorderSide(
            color: Colors.white,
            width: 4, // 2mm white border
          ),
        ),
        // Adjust the size of the floating action button
        // extendedPadding: EdgeInsets.all(20),
        clipBehavior: Clip.none,
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
      color: Colors.white, // Set the bottom navigation bar background color to white
      shape: const CircularNotchedRectangle(), // Make room for the FAB
      notchMargin: 8.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Ensure even spacing between items
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
            color: _selectedIndex == index ? Colors.green : Color.fromRGBO(66, 75, 84, 0.6), // Light black with some opacity
            size: 28, // Increase the icon size
          ),
          Text(
            item['label'],
            style: TextStyle(
              fontSize: 12, // Increase the text size
              color: _selectedIndex == index ? Colors.green : Color.fromRGBO(66, 75, 84, 0.6), // Light black with some opacity
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
          color: Colors.white, // Match the background color of the bottom navigation bar
          size: 28, // Same size as other icons
        ),
        const SizedBox(height: 12), // Maintain same space as text height
      ],
    );
  }

  IconData _getIcon(String? iconString) {
    if (iconString == null || iconString.isEmpty) {
      return Icons.circle; // You can choose any icon that represents an empty space, or create a custom icon
    }
    int code = int.tryParse(iconString.substring(2), radix: 16) ?? 0xe88a; // Default icon codepoint
    return IconData(code, fontFamily: 'MaterialIcons');
  }
}
