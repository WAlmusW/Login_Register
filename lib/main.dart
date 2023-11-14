import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'pages/dashboard.dart';
import 'pages/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Define the initial route
      initialRoute: '/register',
      // Define the routes
      routes: {
        '/register': (context) => RegisterPage(), // Register page
        '/login': (context) => LoginPage(), // Login page
        '/dashboard': (context) => DashboardPage(), // Dashboard page
        // Add other routes here as needed
      },
    );
  }
}
