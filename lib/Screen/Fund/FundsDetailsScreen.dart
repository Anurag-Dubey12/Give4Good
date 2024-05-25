import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:give4good/Screen/Fund/Widgets/CauseButton.dart';

import 'FundBeneficiaryScreen.dart';

class FundsDetailsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => fundscreen();
}

class fundscreen extends State<FundsDetailsScreen> {
  final TextEditingController amountcontroller = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  var selectedReason = 'Education';
  var amount = "0";
  String name = "John Doe";
  String email = "johndoe@example.com";
  String phonenumber = "9004040592";
  String errorMessage = '';
  DateTime? selectedDate;
  void selectReason(String reason) {
    setState(() {
      selectedReason = reason;
    });
  }

  void validateAmount() {
    setState(() {
      if (int.tryParse(amount) == null || int.parse(amount) < 10000) {
        errorMessage = 'Amount should be greater than 10,000';
      } else {
        errorMessage = '';
      }
    });
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}";
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Basic Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 15),
          child: Column(
            children: [
              SizedBox(height: 15),
              Text(
                "I am raising fund for a/an $selectedReason cause",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              SizedBox(height: 15,),
              Text(
                "Select The Cause for Raising Funds:",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Causebutton(
                    text: 'Education',
                    isSelected: selectedReason == 'Education',
                    onTap: () => selectReason('Education'),
                  ),
                  SizedBox(width: 30),
                  Causebutton(
                    text: 'Medical',
                    isSelected: selectedReason == 'Medical',
                    onTap: () => selectReason('Medical'),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Causebutton(
                    text: 'Memorial',
                    isSelected: selectedReason == 'Memorial',
                    onTap: () => selectReason('Memorial'),
                  ),
                  SizedBox(width: 30),
                  Causebutton(
                    text: 'Other',
                    isSelected: selectedReason == 'Other',
                    onTap: () => selectReason('Other'),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Container(
                width: 350,
                child: Column(
                  children: [
                    Text(
                      "Amount You Want To Raise(INR):",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    TextField(
                      controller: amountcontroller,
                      cursorErrorColor: Colors.red,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          amount = value;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter the Amount",
                        errorText: errorMessage.isNotEmpty ? errorMessage : null,
                        suffixIcon: Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            '₹',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "End Date for fund raising:",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: dateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: ()=>_selectDate(context),
                        )
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: 350,
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    TextFormField(
                      initialValue: name,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      initialValue: email,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      initialValue: phonenumber,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        validateAmount();
                        if (errorMessage.isEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Fundbeneficiaryscreen(),
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        overlayColor: Colors.black,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
