
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DonationProgress extends StatelessWidget{
  final String image;
  final String title;
  final int TotalMeal;
  final double MealDonated;
  final int Percentage;
  final List<String> tag;
  
  DonationProgress({
    required this.image,
    required this.title,
    required this.tag,
    required this.MealDonated,
    required this.TotalMeal,
    required this.Percentage,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.center,
      // width:300 ,
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
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.visible,
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

          Container(
            width: 200,
            child: ElevatedButton(
              onPressed: ()async {
                // SharedPreferences prefs=await SharedPreferences.getInstance();
                // await prefs.setString('image', image);
                // await prefs.setString('title', title);
                // await prefs.setStringList('tags', tag);
                // await prefs.setString('donationAmt', Donationamt);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => Amountdonationscreen(),
                //   ),
                // );

              },
              child: Text(
                "Donate Now",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                overlayColor: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}