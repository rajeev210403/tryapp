import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  final _scrollController = ScrollController();

  bool _obscureText = true; // Initially obscure text for password

  String _email = '';
  String _password = '';

  void _handleTap() {
    // Scroll up by 50% of the screen height
    _scrollController.animateTo(
      MediaQuery.of(context).size.height * 0.5,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String? _validateEmail(String? value) {
    if (value == null || !value.contains('@') || !value.endsWith('.com')) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('Email: $_email');
      print('Password: $_password');

      // Send credentials to backend for validation
      var url = Uri.parse('https://devkalgudi.com/v2/auth/login');
      var response = await http.post(url, body: {
        'email': _email,
        'password': _password,
      });
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Successful login
        print('Login successful! Navigating to HomeScreen...');
        // Navigate to the next screen or handle as needed
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Error in login
        print('Login failed: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed. Please check your credentials.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
            onTap: _handleTap,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: Image.asset(
                      'assets/images/splash_image.jpg', // Path to your splash screen image
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Container(
                    color: Colors.grey[200],
                    padding: const EdgeInsets.all(20.0),
                    height: MediaQuery.of(context).size.height,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sign in to RiceTec',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Enter the email and password for the RiceTec account associated',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Enter your email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                              ),
                              validator: _validateEmail,
                              onSaved: (value) => _email = value ?? '',
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: TextFormField(
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                hintText: 'Enter your password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                                suffixIcon: GestureDetector(
                                  onTap: _togglePasswordVisibility,
                                  child: Icon(
                                    _obscureText ? Icons.visibility_off : Icons.visibility,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              validator: _validatePassword,
                              onSaved: (value) => _password = value ?? '',
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: _signIn,
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                shape: MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(30.0),
                                      right: Radius.circular(30.0),
                                    ),
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12.0),
                                child: Text(
                                  'Sign in',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ),
        );
    }
}
