import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:give4good/Screen/Auth/AuthService.dart';
import 'package:give4good/Screen/Auth/Signin.dart';
import 'package:give4good/Screen/Home/HomeScreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Signup extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>UserAuth();
}
class UserAuth extends State<Signup>{
  final _formKey = GlobalKey<FormState>();
  String name='';
  String phone_number='';
  String email='';
  String password='';

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore=FirebaseFirestore.instance;

  Future<User?> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;
      return user;
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Container(
              margin: EdgeInsets.only(left: 10, top: 50, right: 15),
              child: Column(
                children: [
                  Text(
                    "Create an Account",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Image.asset("assets/images/logo.png"),
                  Text(
                    "Connect with",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 15),
                  Container(
                    width: 300,
                    child: SignInButton(
                      Buttons.google,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)
                      ),
                      text: "Sign up with Google",
                      onPressed: () async {
                        User? user = await _signInWithGoogle();
                        if (user != null) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Homescreen()),
                          );
                        }else {
                          // Show error message or handle error
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to Authenticate')),
                          );
                        }
                      },
                    ),
                  ),
                  Text(
                    "Or Continue with email",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    key: ValueKey('name'),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: 'Enter The Name',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.person_2_rounded, color: Colors.grey),
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please Enter Full Name';
                      }
                      else{
                        return null;
                      }
                    },
                    onSaved: (value){
                      setState(() {
                        name=value!;
                      });
                    },
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    key: ValueKey('number'),
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: 'Enter The Mobile Number',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.phone_android, color: Colors.grey),
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (value){
                      if(value!.length<10){
                        return 'Please Enter Proper Number';
                      }
                      else{
                        return null;
                      }
                    },
                    onSaved: (value){
                      setState(() {
                        phone_number=value!;
                      });
                    },
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    key: ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: 'Enter The Email Address',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.email, color: Colors.grey),
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (value){
                      if(value!.isEmpty || !value.contains('@') ){
                        return 'Please Enter Valid Email';
                      }
                      else{
                        return null;
                      }
                    },
                    onSaved: (value){
                      setState(() {
                        email=value!;
                      });
                    },
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    key: ValueKey('password'),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: 'Enter The Password',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.email, color: Colors.grey),
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (value){
                      if(value!.length<6){
                        return 'Please Enter Password of min length 6';
                      }
                      else{
                        return null;
                      }
                    },
                    onSaved: (value){
                      setState(() {
                        password=value!;
                      });
                    },
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () async {
                     if(_formKey.currentState!.validate()){
                       _formKey.currentState!.save();
                       AuthService.signup(name, phone_number, email, password, context);
                       ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(content:Text("Account Created Successfully")));
                       Navigator.pushReplacement(
                         context,
                         MaterialPageRoute(builder: (context) => Homescreen()),
                       );
                       SharedPreferences prefs = await SharedPreferences.getInstance();
                       prefs.setBool("SeenIntro", true);
                     }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content:Text("Something went Wrong")));
                     }
                    },
                    child: Text(
                      "Verify",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      overlayColor: Colors.purple,
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Signin())
                      );
                    },
                    child: Text(
                      "Already have an account? Sign in",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}