import 'package:flutter/material.dart';
import 'dart:convert';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

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
        backgroundColor: Colors.white, // Set the app bar background color to white
        iconTheme: const IconThemeData(color: Colors.black), // Set the app bar icon color to black
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({Key? key});

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Ensure even spacing between items
        children: _bottomNavItems.asMap().entries.map((entry) {
          int index = entry.key;
          dynamic item = entry.value;
          return Expanded(
            child: InkWell(
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
            ),
          );
        }).toList(),
      ),
    );
  }

  IconData _getIcon(String iconString) {
    int code = int.tryParse(iconString.substring(2), radix: 16) ?? 0xe88a; // Default icon codepoint
    return IconData(code, fontFamily: 'MaterialIcons');
  }
}
