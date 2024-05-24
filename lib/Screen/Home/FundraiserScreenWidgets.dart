
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:give4good/Screen/Fund/FundsDetailsScreen.dart';

class Fundraiserscreenwidgets extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>fund();

}
class fund extends State<Fundraiserscreenwidgets>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Donation"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Center(
            child: Column(
              children: [
                Image.asset("assets/images/3.png"),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Text("Fill in a few details about yourself and who you are fundraising for.it take less than 5 minutes."
                      "Receive Donation from friends,family,and even Strangers across  the world",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                ),
                ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>FundsDetailsScreen()));
                  },
                  child: Text("Start a Fundraiser",
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                      overlayColor: Colors.black),),
                SizedBox(height: 15),
                Text(
                  "Need Any help to setup your free fundraiser",
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),
                ),
                ElevatedButton(
                  onPressed: (){
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>FundsDetailsScreen()));
                  },
                  child: Text("Request A Call",
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)
                      ),
                      overlayColor: Colors.black
                  ),)
              ],
            ),
          ),
        ),
      )
    );
  }
}