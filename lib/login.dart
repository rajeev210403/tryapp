import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Login Screen'),
            ElevatedButton(
              onPressed: () {
                // Implement your login functionality here
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
