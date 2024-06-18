import 'package:flutter/material.dart';
import 'bottom_navigation_bar.dart';
import 'legal_screen.dart'; // Import the LegalScreen widget
import 'input.dart'; // Import the InputPage widget

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      bottomNavigationBar: BottomNavigationBarWidget(),
      backgroundColor: Colors.grey[100], // Light grey background color
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCardSection('General', [
                _buildSettingsItem(context, 'Edit profile', InputPage(jsonFilePath: 'assets/jsonfiles/edit_profile.json',)),
                // _buildSettingsItem(context, 'Contact information', InputPage()),
              ]),
              const SizedBox(height: 20),
              _buildCardSection('Legal', [
                _buildSettingsItem(context, 'Privacy Policy', LegalScreen(jsonFilePath: 'assets/jsonfiles/privacy_policy.json')),
                _buildSettingsItem(context, 'Terms and conditions', LegalScreen(jsonFilePath: 'assets/jsonfiles/terms_conditions.json')),
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
                    _logout(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300], // Background color
                    foregroundColor: Colors.black, // Text color
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

  Widget _buildSettingsItem(BuildContext context, String title, Widget screen) {
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
    );
  }

  void _logout(BuildContext context) {
    // Implement your logout functionality here
    print('User logged out');
    // Example: Navigator.pushReplacementNamed(context, '/login');
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
      child: IconButton(
        icon: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          // Add FAB functionality here
        },
      ),
    );
  }
}
