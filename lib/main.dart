import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:give4good/Screen/Auth/SignUp.dart';
import 'package:give4good/Screen/Home/HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screen/IntroScreen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyBf5sdBO2Cp1ATq5W0igKrHGKBharY0maA",
        authDomain: "give4goods-7a166.firebaseapp.com",
        projectId: "give4goods-7a166",
        storageBucket: "give4goods-7a166.appspot.com",
        messagingSenderId: "563321471920",
        appId: "1:563321471920:web:9856e09742227b05da0c75",
        measurementId: "G-RTTJS0Z24K"
    )
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? seen =prefs.getBool("SeenIntro") ?? false;
  runApp( MyApp(seen: seen));
}

class MyApp extends StatelessWidget {
  final bool seen;
  User? user=FirebaseAuth.instance.currentUser;
  MyApp({required this.seen});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Donation Application',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:seen ? (user!=null? Homescreen(): Signup()):Introscreen()
    );
  }
}