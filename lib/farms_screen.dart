import 'package:flutter/material.dart';
import 'bottom_navigation_bar.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'input.dart'; // Import the input.dart file
import 'growers_screen.dart';

class FarmsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        backgroundColor: Colors.green[900],
        child: Icon(Icons.add),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _buildSliverAppBar(),
        _buildCategoryButtons(context),
        _buildResultsSummary(context),
        _buildFarmList(),
      ],
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 20.0),
        child: Text(
          'Farms',
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
    );
  }

  Widget _buildCategoryButtons(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: _buildCategoryButton(context, 'Growers', false)),
              Expanded(child: _buildCategoryButton(context, 'Farms', true)),
              Expanded(child: _buildCategoryButton(context, 'Fields', false)),
            ],
          ),
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
          if (label == 'Growers') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GrowersScreen()),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: selected ? Colors.black : Colors.grey[200],
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

  Widget _buildResultsSummary(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
                  width: 40.0,
                  height: 40.0,
                  child: FloatingActionButton(
                    onPressed: () {
                      _navigateToAddFarm(context);
                      // Add functionality for the add button here
                    },
                    backgroundColor: Colors.green[900],
                    shape: CircleBorder(),
                    elevation: 0,
                    child: Icon(Icons.add, color: Colors.white, size: 20.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFarmList() {
    List<String> farms = [
      'Black soil farm',
      'Green revolution farm',
      'Organic farm',
      'Sunny farm',
      'Misty farm',
      'Golden farm',
      'Harmony farm',
      'Blue sky farm',
      'Rainy day farm',
      'Fertile farm'
    ];

    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          return _buildFarmItem(context, farms[index % farms.length]);
        },
        childCount: farms.length,
      ),
    );
  }

  Widget _buildFarmItem(BuildContext context, String farmName) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    farmName,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {
                    // Handle the options here
                  },
                ),
              ],
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Grower'),
                  Text('Carter Brothers Partnership'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Fields'),
                  Text('14'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Acres'),
                  Text('57'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToAddFarm(BuildContext context) async {
    // Load JSON data (Example: loading a JSON file from assets)
    String jsonData = await rootBundle.loadString('assets/jsonfiles/adding_a_farm.json');
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
}

void main() => runApp(MaterialApp(
  home: FarmsScreen(),
));
