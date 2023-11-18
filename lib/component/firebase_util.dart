import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_udid/flutter_udid.dart';

import 'package:login_register_/firebase_options.dart';

class FirebaseUtil {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> registerUser(String username, String password) async {
    try {
      String deviceUdid = await FlutterUdid.consistentUdid;
      print("debug1");
      // Reference to the "users" collection in Firestore
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      print("debug2");

      int latestUserKey = 1;
      // Fetch the latest user key
      try {
        QuerySnapshot querySnapshot = await users
            .orderBy(FieldPath.documentId, descending: true)
            .limit(1)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          latestUserKey =
              int.parse(querySnapshot.docs.first.id.replaceAll('user', '')) + 1;
        }

        print("debug3");
      } catch (e) {
        latestUserKey = 1; // Default to 1 if no user exists yet

        print("debug3");
      }

      print("debug4: $username: $password");
      // Create a new user with an incremental key
      String userKey = 'user$latestUserKey';
      await users.doc(userKey).set({
        'device_id': deviceUdid,
        'username': username,
        'password': password,
      });

      print('User registered successfully');
    } catch (e) {
      print('Error registering user: $e');
    }
  }

  static Future<void> loginUser(
      String username, String password, Function(bool) onLoginResult) async {
    try {
      // Reference to the "users" collection in Firestore
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      // Query to check if the device ID exists in the "device_id" field
      QuerySnapshot querySnapshot = await users.get();

      // Check each document in the "users" collection
      bool isLoggedIn = false;
      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        // Access the "device_id" field for each user
        String username = document['username'];
        String password = document['password'];

        // If the device ID matches, consider it registered
        if (username == username && password == password) {
          isLoggedIn = true;
          print("debug check");
          break; // No need to continue checking
        }
      }

      // Call the callback function with the login status
      onLoginResult(isLoggedIn);
    } catch (e) {
      print('Error logging in: $e');
    }
  }

  static Future<void> checkRegistrationStatus(
      Function(bool) onStatusChecked) async {
    String deviceUdid = await FlutterUdid.consistentUdid;

    // Reference to the "users" collection in Firestore
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // Query to check if the device ID exists in the "device_id" field
    QuerySnapshot querySnapshot = await users.get();

    // Check each document in the "users" collection
    bool isRegistered = false;
    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      // Access the "device_id" field for each user
      String userDeviceId = document['device_id'];

      // If the device ID matches, consider it registered
      if (userDeviceId == deviceUdid) {
        isRegistered = true;
        print("debug check");
        break; // No need to continue checking
      }
    }

    // Call the callback function with the registration status
    onStatusChecked(isRegistered);
  }
}
