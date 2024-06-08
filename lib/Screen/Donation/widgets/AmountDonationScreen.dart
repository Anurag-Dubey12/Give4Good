import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Amountdonationscreen extends StatefulWidget {
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
      image = prefs.getString('image');
      title = prefs.getString('title');
      tags = prefs.getStringList('tags');
      donationAmt = prefs.getString('donationAmt');
    });
  }
  Future<void> storeTransactionDetails(String paymentId, int amount, String name, String userId) async {
    CollectionReference transactions = FirebaseFirestore.instance.collection('transactions');
    return transactions
        .add({
      'userId': userId,
      'paymentId': paymentId,
      'name': name,
      'amount': amount,
      'cause':'Donation',
      'Date': FieldValue.serverTimestamp(),
    }).then((value) =>   print({
      'payment':paymentId,
      'amount':amount,
      'name':name,
      'userid':userId
    }))
        .catchError((error) => print("Failed to add transaction: $error"));
  }
  void opencheckout(int amount, String? name) async {
    var contact = await FirebaseAuth.instance.currentUser!.phoneNumber;
    var email = await FirebaseAuth.instance.currentUser!.email;
    var options = {
      'key': 'rzp_test_4CmdaLE9sYYEOA',
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
    // Fluttertoast.showToast(
    //     msg: "Payment Successful for payment Id:${response.paymentId}",
    //     toastLength: Toast.LENGTH_SHORT);
    int amount=(_isCustomAmount ? _donationAmount : _currentSliderValue)!.toInt();
    String name=title!;
    storeTransactionDetails(response.paymentId!, amount, name, userid);

    Fluttertoast.showToast(
        msg: "Payment Successful ${response.paymentId}",
        toastLength: Toast.LENGTH_SHORT);
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
                      '$title',
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
                      overlayColor: Colors.black,
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
      body: image == null || title == null || donationAmt == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 15, left: 15, right: 15),
          child: Column(
            children: [
              Text(
                title!,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              SizedBox(height: 15),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  image!,
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

class CustomSliderThumb extends SliderComponentShape{
  late final double thumbRadius;
  late final IconData icon;
  CustomSliderThumb({required this.thumbRadius,required this.icon});
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }
  @override
  void paint(
      PaintingContext context,
      Offset center,
      {required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow})
  {
    final Canvas canvas=context.canvas;
    final paint=Paint()
    ..color=sliderTheme.thumbColor!
    ..style=PaintingStyle.fill;
    canvas.drawCircle(center, thumbRadius, paint);
final iconPainter=TextPainter(
  text: TextSpan(
    text: String.fromCharCode(icon.codePoint),
    style: TextStyle(
      fontSize: thumbRadius,
      fontFamily: icon.fontFamily,
      package: icon.fontPackage,
      color: Colors.white,
    ),
  ),
  textDirection: TextDirection.ltr
);
iconPainter.layout();
iconPainter.paint(
    canvas,
    center-Offset(iconPainter.width/2.0,iconPainter.height/2.0));
  }
}