import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:line_icons/line_icons.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>History();
}
class History extends State<HistoryScreen>{
  List<Donation> donations = [];
  final FirebaseAuth _auth=FirebaseAuth.instance;
  User? _user;
  String? uid;
  @override
  void initState() {
    super.initState();
    fetchData();
    _user=_auth.currentUser;
    if(_user!= null){
      uid=_user!.uid;
    }

  }

  Future<void> fetchData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('transactions').where('userId',isEqualTo: uid).get();
      List<Donation> donationHistory = snapshot.docs.map((doc) {
        Timestamp timestamp = doc['Date'];
        DateTime dateTime = timestamp.toDate();
        String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
        return Donation(
          name: doc['name'],
          cause: doc['cause'],
          date: formattedDate,
          amount: doc['amount'].toDouble(),
        );
      }).toList();
      setState(() {
        donations.addAll(donationHistory);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: 400,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: donations.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          key: Key('donations_list'),
          itemCount: donations.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(LineIcons.donate),
                  ),
                  title: Text("${donations[index].name}"),
                  subtitle:
                  Text("For the ${donations[index].cause} on ${donations[index].date}"),
                  trailing: Text(
                    "₹${donations[index].amount}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: (){
                    _showBottomSheet(context,donations[index]);
                  },
                ),
                Divider(height: 20, thickness: 1)
              ],
            );
          },
        ),
      ),
    );
  }
  void _showBottomSheet(BuildContext context, Donation donation) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Donation Details',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.blue),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              _buildDetailRow('Name', donation.name),
              _buildDetailRow('Cause', donation.cause),
              _buildDetailRow('Date', donation.date),
              _buildDetailRow('Amount', '₹${donation.amount.toStringAsFixed(2)}'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Text(
                  'Donate Again',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }


}
class Donation {
  final String name;
  final String cause;
  final String date;
  final double amount;
  Donation({required this.name, required this.cause, required this.date, required this.amount});
}