
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:give4good/Screen/Donation/DonationWidget.dart';

class Donatescreenwidgets extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>donate();

}
class donate extends State<Donatescreenwidgets>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Donation"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.only(left: 15),
          child: Column(
            children: [
              Text("Choose Where to Donate",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color:Colors.black ),),
              SizedBox(height: 15,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Donationwidget(
                        image: "assets/images/hungry.jpg",
                        title: "Hun",
                        Description: "des",
                        Donationamt: "500",
                        tag: ["Urgerbt","required"],),
                    // SizedBox(width: 15,),
                    // Donationwidget(
                    //     image: "assets/images/hungry.jpg",
                    //     title: "Hun",
                    //     Description: "des"),
                    // SizedBox(width: 15,),
                    // Donationwidget(
                    //     image: "assets/images/hungry.jpg",
                    //     title: "Hun",
                    //     Description: "des"),
                    // SizedBox(width: 15,),
                    // Donationwidget(
                    //     image: "assets/images/hungry.jpg",
                    //     title: "Hun",
                    //     Description: "des"),
                    // SizedBox(width: 15,),
                    // Donationwidget(
                    //     image: "assets/images/hungry.jpg",
                    //     title: "Hun",
                    //     Description: "des")
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}