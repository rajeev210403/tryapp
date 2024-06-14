import 'package:flutter/material.dart';
import 'bottom_navigation_bar.dart'; // Import your custom BottomNavigationBarWidget
import 'speedometer_widget.dart'; // Import the updated speedometer widget

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double cellWidth = MediaQuery.of(context).size.width / 3 - 20;

    List<Widget> listItems = [
      _buildGreetingCard(context),
      _buildSpeedometerSection(),
      _buildAnalyticsSection(cellWidth),
    ];

    return Scaffold(
      appBar: _buildAppBar(),
      bottomNavigationBar: BottomNavigationBarWidget(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: listItems.length,
              itemBuilder: (BuildContext context, int index) {
                return listItems[index];
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(80.0),
      child: AppBar(
        automaticallyImplyLeading: false,
        title: Row(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 20.0),
              child: Text(
                'Home',
                style: TextStyle(
                  fontSize: 40,
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
    );
  }

  Widget _buildFloatingActionButton() {
    return Container(
      margin: EdgeInsets.only(top: 35.0),
      width: 65.0,
      height: 65.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.green[900],
      ),
      child: Icon(Icons.add, color: Colors.white),
    );
  }

  Widget _buildGreetingCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.80,
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.green[800],
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.location_on, color: Colors.white),
                      onPressed: () {},
                      hoverColor: Colors.white.withOpacity(0.3),
                      tooltip: 'Location',
                    ),
                    SizedBox(width: 5.0),
                    Text(
                      'NY district',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    // Add your functionality here
                  },
                  hoverColor: Colors.white.withOpacity(0.3),
                  tooltip: 'Close',
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              'Welcome back, Daniel',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildSpeedometerSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0), // Adjust left padding here
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PLANTING STAGES',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: SpeedometerWidget(
              progress: 0.8, // Example progress value,
              stages: ['PREPARATION', 'PLANTING', 'MANAGEMENT', 'HARVESTING', 'POST-HARVEST'],
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildAnalyticsSection(double cellWidth) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              'ANALYTICS',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildAnalyticsCard(cellWidth, 'Total \nGrowers', '2220'),
                _buildAnalyticsCard(cellWidth, 'Total \nFarmers', '4235'),
                _buildAnalyticsCard(cellWidth, 'Total \nAcres', '90420'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsCard(double width, String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: width,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
