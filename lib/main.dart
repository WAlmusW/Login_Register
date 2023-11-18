import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter_udid/flutter_udid.dart';

import 'package:login_register_/firebase_options.dart';
import 'package:login_register_/component/firebase_util.dart';
import 'package:login_register_/pages/login.dart';
import 'package:login_register_/pages/dashboard.dart';
import 'package:login_register_/pages/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isRegistered = false;
  String _initialRoute = "/";

  @override
  void initState() {
    super.initState();
    FirebaseUtil.checkRegistrationStatus((bool status) {
      setState(() {
        isRegistered = status;
        print(isRegistered);
        if (isRegistered) {
          setState(() {
            _initialRoute = "/login";
          });
        }
        print(_initialRoute);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Register',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      initialRoute: _initialRoute,
      routes: {
        '/': (context) => RegisterPage(),
        '/login': (context) => LoginPage(),
        '/dashboard': (context) => DashboardPage(),
      },
    );
  }
}
