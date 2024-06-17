import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:give4good/Screen/Donation/widgets/AmountDonationScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Donationwidget extends StatelessWidget{
  final String image;
  final String title;
  final List<String> tag;
  final String Donationamt;
  Donationwidget({
    required this.image,
    required this.title,
    required this.tag,
    required this.Donationamt
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  image,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    title+"\n",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2),
         Wrap(
           spacing: 5,
           children: tag.take(3).map((tag){
             return Chip(label: Text(tag,style: TextStyle(color: Colors.black,fontSize: 12),),
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(100),
               side: BorderSide(color: Colors.black)
             ),
             backgroundColor: Colors.transparent,
             );
           }).toList(),
         ),
          SizedBox(height: 2),
          Text("Latest Donation",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
          Text(Donationamt+"₹",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
          Container(
            width: 200,
            child: ElevatedButton(
              onPressed: ()async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Amountdonationscreen(
                      image: image,
                      title: title,
                    ),
                  ),
                );
              },
              child: Text(
                "Donate Now",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                overlayColor: Colors.black,
              ),
            ),
          ),

        ],
      ),
    );
  }
}