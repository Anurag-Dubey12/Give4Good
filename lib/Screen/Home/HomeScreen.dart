import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>homescreen();
}
class homescreen extends State<Homescreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        child: Text("These is home screen"),
      ),
    );
  }

}