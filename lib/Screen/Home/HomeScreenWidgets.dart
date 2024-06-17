import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:give4good/Screen/Auth/Signin.dart';
import 'package:give4good/Screen/Donation/widgets/AmountDonationScreen.dart';
import 'package:give4good/Screen/Donation/widgets/FundraiserCard.dart';
import 'package:give4good/Screen/Donation/widgets/NGOsWidgets.dart';
import 'package:give4good/Screen/Profile/ProfileScreen.dart';
import 'package:give4good/Screen/Widget/HorizontalBanner.dart';
class Homescreenwidgets extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>home();

}
class home extends State<Homescreenwidgets>{
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        appBar: AppBar(
          title: Text("Give4Goods",style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.teal,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(onPressed: () async {
              await FirebaseAuth.instance.signOut();
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content:Text("Logout Successfully")));
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context)=>Signin()));
            },icon: Icon(Icons.logout_rounded,color: Colors.white,)),
            // IconButton(onPressed: (){
            //   Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
            // },icon: Icon(Icons.account_circle_outlined,color: Colors.white,)),
          ],
        ),
        body:SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: EdgeInsets.only(left: 10,bottom:100,right: 10),
            child: Column(
              children: [
                SizedBox(height: 10,),
                Horizontalbanner(
                  banner: ["Donate Food that can save someone's life ","Help People Through various means such as by money,food,non food items",
                    "Some People out there are really need your help","One step towards donation can save many life"],),
                SizedBox(height: 10,),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/images/hungry.jpg",
                        width: 400,
                        height: 150,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "We can do \nsmall things with great love",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "See Active Campaigns",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ListTile(
                  leading: Text("Helping NGOs ",style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),),
                  trailing: Text("See all",
                    style: TextStyle(
                      color: Colors.teal,
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                    ),),
                  onTap: (){

                  },
                ),
               SingleChildScrollView(
                 scrollDirection: Axis.horizontal,
                 child: Row(
                   children: [
                     Ngoswidgets(
                       image: "assets/images/hungry.jpg",
                       NgoName: 'Smile Foundation',
                       NgoLocation: 'Galaxy Tower,Lucknow',
                       NgoRating: "4.5",
                       tag: ["2.4km","Childern Charity"],
                       about: "Smile Foundation was initiated in 2002 when a group of friends came together with the intention of giving back to the society. They were inspired by the thought and philosophy of Peter Senge",
                       phonenumber: "7045858145",
                       mailid: "ad210689@gmail.com",
                     ),
                     Ngoswidgets(
                       image: "assets/images/hungry.jpg",
                       NgoName: 'AgeWell Foundation',
                       NgoLocation: 'Galaxy Tower,Lucknow',
                       NgoRating: "4.5",
                       tag: ["2km","Old Age  Charity"],
                       about: "Need to be added",
                       phonenumber: "8928597751",
                       mailid: "ad210689@gmail.com",
                     ),
                     Ngoswidgets(
                       image: "assets/images/hungry.jpg",
                       NgoName: 'Well Goods Foundation',
                       NgoLocation: 'Paradise Tower,Thane',
                       NgoRating: "3.2",
                       tag: ["5.6km","Cloths Charity"],
                       about: "Need to be added",
                       phonenumber: "7400270555",
                       mailid: "ad210689@gmail.com",
                     ),
                     Ngoswidgets(
                       image: "assets/images/hungry.jpg",
                       NgoName: 'NoWaste Foundation',
                       NgoLocation: 'Fancy Park Tower,Delhi',
                       NgoRating: "4.2",
                       tag: ["2.4km","Books Charity"],
                       about: "Need to be added",
                       phonenumber: "7045858145",
                       mailid: "ad210689@gmail.com",
                     ),
                     Ngoswidgets(
                       image: "assets/images/hungry.jpg",
                       NgoName: 'Well Goods Foundation',
                       NgoLocation: 'Paradise Tower,Thane',
                       NgoRating: "3.2",
                       tag: ["5.6km","Cloths Charity"],
                       about: "Need to be added",
                       phonenumber: "7045858145",
                       mailid: "ad210689@gmail.com",
                     ),
                     Ngoswidgets(
                       image: "assets/images/hungry.jpg",
                       NgoName: 'AgeWell Foundation',
                       NgoLocation: 'Galaxy Tower,Lucknow',
                       NgoRating: "4.5",
                       tag: ["2km","Old Age  Charity"],
                       about: "Need to be added",
                       phonenumber: "7045858145",
                       mailid: "ad210689@gmail.com",
                     ),
                   ],
                 ),
               ),
                ListTile(
                  leading: Text("Urgent Needs ",style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),),
                  trailing: Text("See all",
                    style: TextStyle(
                        color: Colors.teal,
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                    ),),
                  onTap: (){
                    // Navigator.pushReplacement(
                    //     context, MaterialPageRoute(builder: (BuildContext context)=>Donatescreenwidgets()));
                  },
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                     FundraiserCard(
                         image:  "assets/images/hungry.jpg",
                         title: "Help for riyan Surgery",
                         amountRaised: 4000,
                         totalAmount: 40000,
                         donors: 150,
                         daysLeft: 3,

                     ),
                      FundraiserCard(
                          image:  "assets/images/hungry.jpg",
                          title: "Help for riyan Surgery",
                          amountRaised: 4000,
                          totalAmount: 4000,
                          donors: 150,
                          daysLeft: 3,
                      ),
                      FundraiserCard(
                          image:  "assets/images/hungry.jpg",
                          title: "Help for riyan Surgery",
                          amountRaised: 4000,
                          totalAmount: 4000,
                          donors: 150,
                          daysLeft: 3,
                      ),
                      FundraiserCard(
                          image:  "assets/images/hungry.jpg",
                          title: "Help for riyan Surgery",
                          amountRaised: 4000,
                          totalAmount: 40000,
                          donors: 150,
                          daysLeft: 3,
                      ),
                      FundraiserCard(
                          image:  "assets/images/hungry.jpg",
                          title: "Help for riyan Surgery",
                          amountRaised: 4000,
                          totalAmount: 4000,
                          donors: 150,
                          daysLeft: 3,

                      ),
                      FundraiserCard(
                          image:  "assets/images/hungry.jpg",
                          title: "Help for riyan Surgery",
                          amountRaised: 4000,
                          totalAmount: 4000,
                          donors: 150,
                          daysLeft: 3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class CategoryButton extends StatelessWidget{
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  CategoryButton({required this.label,required this.icon,required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.teal,
          child: IconButton(
            icon: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
            },
          ),
        ),
        SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}