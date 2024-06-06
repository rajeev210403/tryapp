import 'package:flutter/material.dart';
import 'package:tryapp/bottom_navigation_bar.dart'; // Import the BottomNavigationBarWidget component

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
              padding: const EdgeInsets.only(left: 10.0, top: 10.0),
              child: Text(
                'Home',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right:10.0,top: 10.0),
              child: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // Add search functionality here
                },
              ),
            ),
          ],
        ),
        actions: [],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(), // Use the BottomNavigationBarWidget component
    );
  }
}
