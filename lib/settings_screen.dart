import 'package:flutter/material.dart';
import 'bottom_navigation_bar.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      bottomNavigationBar: BottomNavigationBarWidget(),
      backgroundColor: Colors.grey[100], // Light green background color
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCardSection('General', [
                _buildSettingsTile(context, 'Edit profile'),
                _buildSettingsTile(context, 'Contact information'),
              ]),
              const SizedBox(height: 20),
              _buildCardSection('Legal', [
                _buildSettingsTile(context, 'Privacy Policy'),
                _buildSettingsTile(context, 'Terms and conditions'),
              ]),
              const SizedBox(height: 30),
              Center(
                child: Text(
                  'example@gmail.com',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 90),
              Container(
                width: double.infinity, // Make button span full width
                child: ElevatedButton(
                  onPressed: () {
                    // Add log out functionality here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300], // background color
                    foregroundColor: Colors.black,
                    // text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text(
                    'Log out',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
        title: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(
            'Settings',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.green[900]),
      ),
    );
  }

  Widget _buildCardSection(String title, List<Widget> children) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 1.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsTile(BuildContext context, String title) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Colors.black,
        size: 20,
      ),
      onTap: () {
        // Add navigation or other functionality here
      },
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
}
