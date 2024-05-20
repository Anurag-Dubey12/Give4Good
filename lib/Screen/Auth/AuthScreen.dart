
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:give4good/Screen/Home/HomeScreen.dart';

class Authscreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>UserAuth();
}
class UserAuth extends State<Authscreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          // margin: EdgeInsets.symmetric(vertical: 100),
          margin: EdgeInsets.only(left: 10,top: 100),
          child: Column(
            children: [
              Text("Create an Account or sign in",
                style: TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 25,color: Colors.black,fontStyle: FontStyle.italic),),
              Image.asset("assets/images/logo.png"),
              Text("Connect with",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: (){},
                      icon: Image.asset("assets/images/facebook.png")
                  ),
                  SizedBox(width: 15,),
                  IconButton(
                      onPressed: (){},
                      icon: Image.asset("assets/images/google.png")),
                ],
              ),
              Text("Or Continue with email",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),),
              SizedBox(height: 15,),
              TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              hintText: 'Enter The Name',
              hintStyle: TextStyle(color: Colors.grey),
              // prefixIcon: Icon(Icons.search, color: Colors.grey),
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
            style: TextStyle(color: Colors.black),
          ),
              SizedBox(height: 15,),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: 'Enter The Email Address',
                  hintStyle: TextStyle(color: Colors.grey),
                  // prefixIcon: Icon(Icons.search, color: Colors.grey),
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
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 15,),
              ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Homescreen()));
                  },
                  child: Text("Verify",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    overlayColor: Colors.purple

                  ),),
              Container(
                  margin: EdgeInsets.only(top: 90,left:25,right: 15),
                  child: Center(
                      child: Text("By Signing up ,you are agreeing to our Privacy policy \n                                and Terms Of Use",style: TextStyle(fontSize: 15),)))
            ],

          ),
        ),
      ),
    );
  }

}