
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:give4good/Screen/Donation/widgets/CategoryItem.dart';
import 'package:url_launcher/url_launcher.dart';

import 'FoodScreen.dart';
import 'NonFoodScreen.dart';

class Ngodescription extends StatelessWidget{
  String image;
  String NGOName;
  String Location;
  List<String> tags;
  String Rating;
  String about;
  String phonenumber;
  String mailid;

  Ngodescription({
    required this.image,
    required this.NGOName,
    required this.Location,
    required this.tags,
    required this.Rating,
    required this.about,
    required this.phonenumber,
    required this.mailid,
});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: Colors.black),
            onPressed: () {
              // Handle share button press
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.verified, color: Colors.teal),
                      SizedBox(width: 8),
                      Text(
                        'Verified by Give4Goods',
                        style: TextStyle(color: Colors.teal),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.phone, color: Colors.teal),
                        onPressed: () {
                          _makePhoneCall(phonenumber);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.email, color: Colors.teal),
                        onPressed: () {
                          _sendEmail(mailid);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    NGOName,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(Location),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Wrap(
                        spacing: 8,
                        children: tags.map((tag) => _buildChip(tag)).toList(),
                      )
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Text('Reviews', style: TextStyle(fontSize: 16)),
                      Spacer(),
                      Text(
                        Rating,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.star, color: Colors.amber),
                      SizedBox(width: 8),
                      Text('850 Reviews'),
                      SizedBox(width: 8),
                      CircleAvatar(
                        radius: 12,
                        backgroundImage: AssetImage('assets/user1.jpg'),
                      ),
                      CircleAvatar(
                        radius: 12,
                        backgroundImage: AssetImage('assets/user2.jpg'),
                      ),
                      CircleAvatar(
                        radius: 12,
                        backgroundImage: AssetImage('assets/user3.jpg'),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'About',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    about
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _showBottomSheet(context);
                      },
                      child: Text('Make Donation',style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(color: Colors.black, fontSize: 12),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
        side: BorderSide(color: Colors.black),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CategoryItem(
                  icon: Icons.local_dining,
                  iconColor: Colors.purple,
                  title: 'Food',
                  subtitle: 'Give away anything you would eat yourself',
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Foodscreen()));
                  },
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey,
                ),
                CategoryItem(
                  icon: Icons.cleaning_services,
                  iconColor: Colors.pink,
                  title: 'Non-food',
                  subtitle: 'Give away toiletries, cosmetics, kitchen utensils, toys, clothes etc',
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Nonfoodscreen()));
                  },
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey,
                ),
              ],
            ),
          );
        });
  }
  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
  void _sendEmail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launchUrl(launchUri);
  }
}