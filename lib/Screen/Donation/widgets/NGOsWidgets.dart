
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:give4good/Screen/Donation/NGODescription.dart';

class Ngoswidgets extends StatelessWidget{
  final String image;
  final String NgoName;
  final String NgoLocation;
  final String NgoRating;
  final List<String> tag;
  final String about;
  final String phonenumber;
  final String mailid;

  Ngoswidgets({
   required this.image,
   required this.NgoName,
   required this.NgoLocation,
   required this.NgoRating,
   required this.tag,
   required this.about,
   required this.phonenumber,
   required this.mailid,

});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context)=>Ngodescription(
          image: image,
          NGOName: NgoName,
          Location: NgoLocation,
          tags: tag,
          Rating: NgoRating,
          about:about,
          phonenumber: phonenumber,
          mailid: mailid,
        )));
      },
      child: Container(
        margin: EdgeInsets.only(left: 5,right: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        NgoName,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 6,),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow[700],
                            size: 16.0,
                          ),
                          Text(
                            NgoRating,
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    NgoLocation,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8.0),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}