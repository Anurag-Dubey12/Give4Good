import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserProvider with ChangeNotifier {
  String _userName = '';
  String _email = '0';
  String _phone_number = '0';
  String _userProfileImage = 'assets/images/logo.png';
  List<Map<String, dynamic>> _donations = [];
  final FirebaseAuth _auth=FirebaseAuth.instance;
  User? _user;
  String? uid;
  String get userName => _userName;
  String get email => _email;
  String get phonenumber => _phone_number;
  String get userProfileImage => _userProfileImage;
  List<Map<String, dynamic>> get donations => _donations;

  UserProvider() {
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    print("UID:$user");
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('Users').doc(user.uid).get();
      if (userDoc.exists) {
        _userName = userDoc['name'] ?? 'Unknown';
        _email = userDoc['email']?.toString() ?? '0';
        _phone_number = userDoc['phone_number']?.toString() ?? '0';
        _userProfileImage = userDoc['profileImage'] ?? 'assets/images/logo.png';

        if (userDoc['donations'] != null) {
          List<dynamic> donationList = userDoc['donations'];
          _donations = donationList.map((donation) => {
            'date': donation['date'],
            'amount': donation['amount'],
            'ngo': donation['ngo'],
          }).toList();
        }
        notifyListeners();
      }
    }
  }

}
