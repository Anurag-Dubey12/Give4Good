import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:give4good/Screen/Donation/widgets/CustomSliderThumb.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Amountdonationscreen extends StatefulWidget {
  String? image;
  String? title;
  Amountdonationscreen({
    required this.image,
    required this.title,
  });
  @override
  State<StatefulWidget> createState() => DonationPage();
}
class DonationPage extends State<Amountdonationscreen>{
  String? image;
  String? title;
  List<String>? tags;
  String? donationAmt;
  double _currentSliderValue = 60;
  double? _donationAmount;
  bool _isCustomAmount = false;
  final TextEditingController _newmealamt = TextEditingController();
  late Razorpay razorpay;
  TextEditingController amtcontroller = TextEditingController();


  @override
  void initState() {
    _loadDonationDetails();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  Future<void> _loadDonationDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      image=widget.image;
      title=widget.title;
    });
  }
  Future<void> storeTransactionDetails(String paymentId, int amount, String name, String userId) async {
    try {
      CollectionReference transactions = FirebaseFirestore.instance.collection('transactions');
      DocumentReference newTransactionRef = transactions.doc();

      await newTransactionRef.set({
        'userId': userId,
        'paymentId': paymentId,
        'name': name,
        'amount': amount,
        'cause': 'Donation',
        'Date': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      print('Transaction added successfully: { '
          'paymentId: $paymentId, '
          'amount: $amount, '
          'name: $name, '
          'userId: $userId '
          '}');

    } catch (error) {
      print("Failed to add transaction: $error");
      throw Exception("Failed to add transaction: $error");
    }
  }

  void opencheckout(int amount, String? name) async {
    var contact = await FirebaseAuth.instance.currentUser!.phoneNumber;
    var email = await FirebaseAuth.instance.currentUser!.email;
    var options = {
      'key': 'rzp_test_6ALJzRFk7QdVEe',
      'amount': amount * 100,
      'name': name,
      'description': 'Donation For People',
      'prefill': {
        'contact': contact,
        'email': email,
      },
    };
    try {
      razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    String userid=FirebaseAuth.instance.currentUser!.uid;
    int amount=(_isCustomAmount ? _donationAmount : _currentSliderValue)!.toInt();
    String name=title!;
    storeTransactionDetails(response.paymentId!, amount, name, userid);
    Fluttertoast.showToast(
        msg: "Payment Successful ${response.paymentId}",
        toastLength: Toast.LENGTH_SHORT);
    Navigator.pop(context);
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Unsuccessful due to ${response.message}",
        toastLength: Toast.LENGTH_SHORT);
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "External Wallet ${response.walletName}",
        toastLength: Toast.LENGTH_SHORT);
  }

  void _showBottomSheet(BuildContext context) {
    String amountErrorMessage = '';
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 16),
                  Center(
                    child: Text(
                      '${widget.title}',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Your amount',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Please enter the custom amount that you want to donate. Our minimum donation is ₹60.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _newmealamt,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Your amount',
                      errorText: amountErrorMessage.isEmpty
                          ? null
                          : amountErrorMessage,
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      // overlayColor: Colors.black,
                    ),
                    onPressed: () {
                      var newvalue = int.tryParse(_newmealamt.text) ?? 0;
                      if (newvalue < 60) {
                        setState(() {
                          amountErrorMessage =
                          "Donation Amount should be greater than 60";
                        });
                      } else {
                        setState(() {
                          amountErrorMessage = '';
                          _donationAmount = newvalue.toDouble();
                          _isCustomAmount = true;
                        });
                        Navigator.pop(context, newvalue.toString());
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    ).then((newvalue) {
      if (newvalue != null) {
        setState(() {
          _donationAmount = double.parse(newvalue);
          _isCustomAmount = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: widget.image == null || widget.title == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 15, left: 15, right: 15),
          child: Column(
            children: [
              Text(
                widget.title!,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              SizedBox(height: 15),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  widget.image!,
                  width: 400,
                  height: 400,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 15),
              Container(
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '₹${_isCustomAmount ? _donationAmount : _currentSliderValue}',
                      style: TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () {
                          _showBottomSheet(context);
                        },
                        icon: Icon(
                          Icons.edit_rounded,
                          color: Colors.blue,
                        ))
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: 300,
                child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        activeTickMarkColor: Colors.blue,
                        inactiveTrackColor: Colors.grey,
                        trackShape: RoundedRectSliderTrackShape(),
                        trackHeight: 20,
                        minThumbSeparation: 20,
                        thumbShape: CustomSliderThumb(
                            thumbRadius: 20, icon: Icons.food_bank),
                        thumbColor: Colors.blue,
                        overlayColor:
                        Colors.blue.withAlpha(32),
                        overlayShape: RoundSliderOverlayShape(
                            overlayRadius: 28)),
                    child: Slider(
                      value: _currentSliderValue,
                      min: 60,
                      max: 15000,
                      divisions: (15000 - 60) ~/ 60,
                      label: _currentSliderValue.round().toString(),
                      onChanged: (value) {
                        setState(() {
                          _currentSliderValue  =
                              (value / 60).round() * 60;
                          _isCustomAmount = false;
                        });
                      },
                    )),
              ),
              SizedBox(height: 15),
              Container(
                width: 250,
                child: ElevatedButton(
                  onPressed: () {
                    opencheckout(
                        (_isCustomAmount ? _donationAmount : _currentSliderValue)!.toInt(),
                        title);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

