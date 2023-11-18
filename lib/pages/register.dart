import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:login_register_/firebase_options.dart';
import 'package:login_register_/component/firebase_util.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController _username;
  late final TextEditingController _password;

  @override
  void initState() {
    _username = new TextEditingController();
    _password = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _username,
                decoration: InputDecoration(
                  hintText: "Enter your username here",
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person),
                ),
                enableSuggestions: false,
                autocorrect: false,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _password,
                decoration: InputDecoration(
                  hintText: "Enter your password here",
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                onPressed: () async {
                  final username = _username.text;
                  final password = _password.text;

                  try {
                    FirebaseUtil.registerUser(username, password);
                    Navigator.pushNamed(context, '/dashboard');
                  } catch (e) {
                    print("Register failed");
                  }
                },
                child: const Text(
                  'Register',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
