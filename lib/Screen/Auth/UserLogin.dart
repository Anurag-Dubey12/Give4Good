
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserLogin extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => UserloginState();
}
class UserloginState extends State<UserLogin>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("User"),
      ),

    );
  }

}