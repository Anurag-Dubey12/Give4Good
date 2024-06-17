
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Home/DonateScreenWidgets.dart';

class Donationsucess extends StatelessWidget{

  String title;
  String des;
  String Quantity;
  String pickadd;

  Donationsucess({
    required this.title,
    required this.des,
    required this.Quantity,
    required this.pickadd,
});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text("Donation Status",style: TextStyle(color: Colors.white),),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.card_giftcard,
                    size: 100,
                    color: Colors.teal,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Donation Placed',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // SizedBox(height: 8),
                  // GestureDetector(
                  //   onTap: () {
                  //   },
                  //   child: Text(
                  //     'View Donation Details',
                  //     style: TextStyle(
                  //       color: Colors.teal,
                  //       decoration: TextDecoration.underline,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 20),
                  buildInfoCard(
                    context,
                    title,
                    des,
                    Icons.verified_user,
                  ),
                  SizedBox(height: 16),
                  buildInfoCard(
                    context,
                    'Quantity',
                    Quantity,
                    Icons.production_quantity_limits,
                  ),
                  SizedBox(height: 16),
                  buildInfoCard(
                    context,
                    'Pickup address',
                    pickadd,
                    Icons.location_on,
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed:(){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context)=>Donatescreenwidgets()));
                      Navigator.pop(context);
                    },
                    child: Text('Home',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Icon(Icons.support_agent),
                        Text("Our Agent Will reach out to you sortly",
                        style: TextStyle(fontSize: 16),)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoCard(
      BuildContext context, String title, String subtitle, IconData icon) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.teal),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}