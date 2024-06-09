import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:give4good/Screen/Donation/widgets/DonationWidget.dart';
class Donatescreenwidgets extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>donate();

}
class donate extends State<Donatescreenwidgets> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Donation"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        margin: EdgeInsets.only(bottom: 100),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Choose Where to Donate",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Ongoing hunger Crises",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Some of the world's Biggest emergencies that we help long term",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 5),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Donationwidget(
                        image: "assets/images/hungry.jpg",
                        title: "Yamen:Give Vital Aid",
                        Donationamt: "500",
                        tag: ["Nutrition", "Emercency"],
                      ),
                      // DonationProgress(
                      //   image: "assets/images/hungry.jpg",
                      //   title: "Yamen:Give Vital Aid",
                      //   tag: ["Nutrition", "Emercency"],
                      //   TotalMeal: 20000,
                      //   MealDonated: 1000,
                      //   Percentage: 10,
                      // ),
                      // SizedBox(width: 15),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Need Some Love",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Fundraising goals with low progress, help show them support!",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
               SingleChildScrollView(
                 scrollDirection: Axis.horizontal,
                 child: Row(
                   children: [
                     Donationwidget(
                       image: "assets/images/hungry.jpg",
                       title: "Sudan:Help Families Feeling Conflict",
                       Donationamt: "5000",
                       tag: ["Emercency","Childern"],
                     ),
                     Donationwidget(
                       image: "assets/images/hungry.jpg",
                       title: "Haiti:Help Conflict-affected Families",
                       Donationamt: "500",
                       tag: ["Emercency","Childern"],
                     ),
                     Donationwidget(
                       image: "assets/images/hungry.jpg",
                       title: "South Sudan:Support Families Through Innovation",
                       Donationamt: "2500",
                       tag: ["Climate Change"],
                     ),
                     Donationwidget(
                       image: "assets/images/hungry.jpg",
                       title: "Rwanda,Peru,Zambia:Empower Women",
                       Donationamt: "6000",
                       tag: ["Climate Change"],
                     ),
                   ],
                 ),
               ),
                SizedBox(height: 5),
                Text(
                  "Last Chance to Donate",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Fundraising goals that are almost complete help them to reach their target",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Donationwidget(
                        image: "assets/images/hungry.jpg",
                        title: "Afganistan:Donate emergency support",
                        Donationamt: "5000",
                        tag: ["Emercency","Childern"],
                      ),
                      Donationwidget(
                        image: "assets/images/hungry.jpg",
                        title: "Syria:Share with families in need",
                        Donationamt: "500",
                        tag: ["Emercency","Childern"],
                      ),
                      Donationwidget(
                        image: "assets/images/hungry.jpg",
                        title: "Egypt:Support sustainable farming",
                        Donationamt: "2500",
                        tag: ["Climate Change"],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}