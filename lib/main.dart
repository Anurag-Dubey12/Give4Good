import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:give4good/Screen/Auth/SignUp.dart';
import 'package:give4good/Screen/Home/HomeScreen.dart';
import 'package:give4good/Screen/Profile/UserProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screen/IntroScreen.dart';
import 'package:path_provider/path_provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyA4MkV9EJ8Jpz6oQb8TJqigfDW4nOvTDoY",
        authDomain: "give4good-90ed5.firebaseapp.com",
        projectId: "give4good-90ed5",
        storageBucket: "give4good-90ed5.appspot.com",
        messagingSenderId: "742348535375",
        appId: "1:742348535375:web:f75d644014ceac99511c3a",
        measurementId: "G-612TL5VZ4L"
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
    return MultiProvider(
        providers:[
          ChangeNotifierProvider(create: (context) => UserProvider())
        ],
        child:  MaterialApp(
        title: 'Donation Application',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:seen ? (user!=null? Homescreen(): Signup()):Introscreen()
    ),
    )
     ;
  }
}