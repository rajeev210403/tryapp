import 'package:flutter/material.dart';
import 'package:tryapp/home_screen.dart';
import 'dart:convert';
import 'growers_screen.dart'; // Import the GrowersScreen

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({Key? key}) : super(key: key);

  @override
  _BottomNavigationBarWidgetState createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState
    extends State<BottomNavigationBarWidget> {
  int _selectedIndex = 0;
  List<dynamic> _bottomNavItems = [];

  @override
  void initState() {
    super.initState();
    _loadBottomNavItems();
  }

  Future<void> _loadBottomNavItems() async {
    try {
      String data = await DefaultAssetBundle.of(context)
          .loadString('assets/jsonfiles/bottom_bar.json');
      setState(() {
        _bottomNavItems = List<dynamic>.from(json.decode(data));
      });
    } catch (e) {
      print('Error loading JSON: $e');
    }
  }
  void _onItemTapped(int index) {
    print('Tapped index: $index'); // Print tapped index for debugging
    // _selectedIndex = index;
    setState(() {
      _selectedIndex = index;
    });

    print('Selected index after setState: $_selectedIndex'); // Print selected index after updating state

    switch (_bottomNavItems[index]['label']) {
      case 'Home':
        print('Navigating to HomeScreen'); // Debug statement to verify navigation
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        ).then((_) {
          // Optional: Update _selectedIndex after returning from HomeScreen

        });
        break;
      case 'Growers':
        print('Navigating to GrowersScreen'); // Debug statement to verify navigation
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GrowersScreen()),
        ).then((_) {

        });
        break;
    // Add cases for other navigation items as needed
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
          SizedBox(width: 60.0), // Empty space between 2nd and 3rd icon
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
    bool isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getIcon(item['icon']),
            color: isSelected ? Colors.green[900] : Color.fromRGBO(66, 75, 84, 0.6),
            size: 28,
          ),
          Text(
            item['label'],
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Colors.green[900] : Color.fromRGBO(66, 75, 84, 0.6),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildEmptyItem() {
    return SizedBox.shrink(); // Empty item
  }

  IconData _getIcon(String? iconString) {
    if (iconString == null || iconString.isEmpty) {
      return Icons.circle;
    }
    int code = int.tryParse(iconString.substring(2), radix: 16) ?? 0xe88a;
    return IconData(code, fontFamily: 'MaterialIcons');
  }
}
