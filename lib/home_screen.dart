import 'package:flutter/material.dart';
import 'bottom_navigation_bar.dart'; // Import your custom BottomNavigationBarWidget

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0), // Adjust the height as needed
        child: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                child: Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(), // Use your custom bottom navigation bar
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: 50, // Example count of items
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: EdgeInsets.only(top: 35.0),
        width: 65.0,
        height: 65.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green,
        ),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
