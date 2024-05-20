import 'package:flutter/material.dart';
import 'package:give4good/Screen/Auth/AuthScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screen/IntroScreen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? seen =prefs.getBool("SeenIntro") ?? false;
  runApp( MyApp(seen: seen));
}

class MyApp extends StatelessWidget {
  final bool seen;
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
      home:seen ? Authscreen():Introscreen()
    );
  }
}
