
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
class HistoryScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>History();
}
class History extends State<HistoryScreen>{
  List<Donation> donation=[];
  @override
  void initState() {
    FetchData();
  }
  void FetchData() async{
    await Future.delayed(Duration(seconds: 2));
    List<Donation> newdonation=[
      Donation(Name: 'Yaen',Cause: "Donation", amount: 150.0, Date: '2024-06-04'),
      Donation(Name: 'Yaen',Cause: "Donation", amount: 150.0, Date: '2024-06-04'),
      Donation(Name: 'Yaen',Cause: "Donation", amount: 150.0, Date: '2024-06-04'),
    ];
    setState(() {
      donation.addAll(newdonation);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History",style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
        width: 400,
        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
        child:donation.isEmpty
          ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: donation.length,
            itemBuilder: (BuildContext context,int index){
            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(LineIcons.donate),
                  ),
                  title: Text("${donation[index].Name}"),
                  subtitle: Text(" For the ${donation[index].Cause} on ${donation[index].Date}"),
                  trailing: Text("₹${donation[index].amount}",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                ),
                Divider(height: 20,thickness: 1,)
              ],
            );
            },
        )
      ),
    );
  }
}
class Donation {
  final String Name;
  final String Cause;
  final String Date;
  final double amount;
  Donation({required this.Name,required this.Cause,required this.Date,required this.amount});
}