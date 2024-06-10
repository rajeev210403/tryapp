import 'package:flutter/material.dart';
import 'bottom_navigation_bar.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'input.dart'; // Import the input.dart file

class GrowersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: EdgeInsets.only(top: 35.0),
        width: 65.0,
        height: 65.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green[900],
        ),
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 20.0),
            child: Text(
              'Growers',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0, top: 20.0),
              child: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // Add search functionality here
                },
              ),
            ),
          ],
          iconTheme: IconThemeData(color: Colors.black),
          expandedHeight: 80.0,
          floating: true,
          pinned: false,
          flexibleSpace: FlexibleSpaceBar(),
        ),
        SliverToBoxAdapter(
          child: _buildCategoryButtons(context),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // Add top and bottom padding
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '450 Results',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.sort),
                      onPressed: () {
                        // Add sorting functionality here
                      },
                    ),
                    SizedBox(width: 10.0),
                    Container(
                      width: 40.0, // Set the desired width
                      height: 40.0, // Set the desired height
                      child: FloatingActionButton(
                        onPressed: () {
                          _navigateToAddGrower(context); // Call a function to navigate to input.dart
                          // Add functionality for the add button here
                        },
                        backgroundColor: Colors.green[900],
                        shape: CircleBorder(),
                        elevation: 0, // Set elevation to 0
                        child: Icon(Icons.add, color: Colors.white, size: 20.0), // Set icon size
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return _buildGrowerItem(context, index);
            },
            childCount: 10,
          ),
        ),
      ],
    );
  }
  // Function to navigate to input.dart and pass JSON data
  void _navigateToAddGrower(BuildContext context) async {
    // Load JSON data
    String jsonData = await rootBundle.loadString('assets/jsonfiles/adding_a_grower.json');
    // Parse JSON
    Map<String, dynamic> data = json.decode(jsonData);
    // Navigate to input.dart and pass JSON data
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InputPage(jsonData: data),
      ),
    );
  }

  Widget _buildCategoryButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0), // Add top and bottom padding
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0), // Add left and right margins
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: _buildCategoryButton(context, 'Growers', true),
            ),
            Expanded(
              child: _buildCategoryButton(context, 'Farms', false),
            ),
            Expanded(
              child: _buildCategoryButton(context, 'Fields', false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(BuildContext context, String label, bool selected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ElevatedButton(
        onPressed: () {
          // Add category selection functionality here
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: selected ? Colors.black : Colors.grey[200], // Change color based on selection
          foregroundColor: selected ? Colors.white : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }


  Widget _buildGrowerItem(BuildContext context, int index) {
    List<String> growers = [
      'Carter Brothers Partnership',
      'Don Kittler Farms',
      'Bearskin Farm',
      'Ronald Rancho',
      'Trump & Smith Farm',
      'Bearskin Farm',
      'Don Kittler Farms',
      'Carter Brothers Partnership',
      'Ronald Rancho',
      'Don Kittler Farms'
    ];

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        title: Text(growers[index % growers.length]),
        trailing: PopupMenuButton<String>(
          onSelected: (String value) {
            // Handle selection of menu items here
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                value: 'edit',
                child: ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Edit'),
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: ListTile(
                  leading: Icon(Icons.delete, color: Colors.red),
                  title: Text('Delete', style: TextStyle(color: Colors.red)),
                ),
              ),
            ];
          },
        ),
      ),
    );
  }
}
