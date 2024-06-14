import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'home_screen.dart';
import 'growers_screen.dart'; // Import the GrowersScreen
import 'programs_screen.dart'; // Import the ProgramsScreen
import 'settings_screen.dart'; // Import the SettingsScreen
import 'farms_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(),
        '/growers': (context) => GrowersScreen(),
        '/farms': (context) => FarmsScreen(),
        '/programs': (context) => ProgramsScreen(),
        '/settings': (context) => SettingsScreen(),
        // Add other routes here as needed
      },
    );
  }
}
