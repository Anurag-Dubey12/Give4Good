

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FundraiserCard extends StatelessWidget {
  final String image;
  final String title;
  final double amountRaised;
  final double totalAmount;
  final int donors;
  final int daysLeft;
  final VoidCallback onPressed;
  FundraiserCard({
    required this.image,
    required this.title,
    required this.amountRaised,
    required this.totalAmount,
    required this.donors,
    required this.daysLeft,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 6.0,
        //     spreadRadius: 2.0,
        //   ),
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
            child: Image.asset(
              image,
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            '₹${amountRaised.toStringAsFixed(0)} raised from ₹${totalAmount.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 4.0),
          LinearProgressIndicator(
            value: amountRaised / totalAmount,
            backgroundColor: Colors.grey[300],
            color: Colors.teal,
            minHeight: 5.0,
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$donors donors',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                '$daysLeft days left',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          ElevatedButton(
            onPressed: onPressed,
            child: Text('Donate Now',style: TextStyle(color: Colors.white),),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              minimumSize: Size(double.infinity, 36),
            ),
          ),
          SizedBox(height: 8.0),
          OutlinedButton(
            onPressed: onPressed,
            child: Text('Know more',style: TextStyle(color: Colors.teal),),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.teal, side: BorderSide(color: Colors.teal),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              minimumSize: Size(double.infinity, 36),
            ),
          ),
        ],
      ),
    );
  }
}