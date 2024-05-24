
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FundsDetailsScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>fundscreen();
}
class fundscreen extends State<FundsDetailsScreen>{
  var reason= 'Education';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fundraiser"),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 15),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Text("Basic Details",style: TextStyle(fontSize: 22,color: Colors.black,fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 15),
            Text("I am raising fund for a/an $reason cause",
                style: TextStyle(fontSize: 18,color: Colors.black)),

          ],
        ),
      ),
    );
  }

}