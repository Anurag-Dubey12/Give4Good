import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

class Foodscreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> foodscreen();
}
class foodscreen extends State<Foodscreen>{
  int _selectedQuantity = 1;
  bool _isOtherSelected = false;
  List<XFile>? _images=[];
  bool _isuploading=false;
  bool _isListingDays = false;
  LatLng? _currentPosition;

  BitmapDescriptor currenticon=BitmapDescriptor.defaultMarker;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _pickupInstructionsController = TextEditingController();
  final TextEditingController _otherQuantityController = TextEditingController();
  int? _listingDays;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  String? _uid;
  DocumentReference? _docRef;
  String? _DocId;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    _getCurrentLocation();
    _docRef = _firestore.collection('Foods').doc();
    _user=_auth.currentUser;
    if(_user!=null){
      setState(() {
        _uid=_user!.uid;
        _DocId=_docRef!.id;
      });
    }
  }
  Future<void> _StoreFoodsData() async{
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty || _images == null || _images!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("All fields are required")));
      return;
    }
    setState(() {
      _isuploading = true;
    });
    try{
     List<String> imageUrls=await _StoreImages();
     await FirebaseFirestore.instance.collection('Foods')
     .add({
       'title': _titleController.text,
       'description': _descriptionController.text,
       'quantity': _isOtherSelected ? int.tryParse(_otherQuantityController.text) : _selectedQuantity,
       'pickupInstructions': _pickupInstructionsController.text,
       'location': GeoPoint(_currentPosition!.latitude, _currentPosition!.longitude),
       'images': imageUrls,
       'listingDays': _listingDays,
       'createdAt': FieldValue.serverTimestamp(),
       'User_Uid':_uid,
       'Doc_Id':_DocId,
     });
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Food data uploaded successfully")));
     Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to upload data :${e}")));
    } finally {
      setState(() {
        _isuploading = false;
      });
    }
  }

  Future<List<String>> _StoreImages() async{
    List<String> imageurl=[];
    for (XFile image in _images!){
      String Filename=image.name;
      Reference storagereference=FirebaseStorage.instance
          .ref().child("Food_Images").child(Filename);
      UploadTask uploadTask=storagereference.putFile(File(image.path));
      TaskSnapshot taskSnapshot=await uploadTask;
      String imageUrls=await taskSnapshot.ref.getDownloadURL();
      imageurl.add(imageUrls);
    }
    return imageurl;
  }

  Future<void> _pickimages()async{
    final List<XFile> selectedimages=await ImagePicker().pickMultiImage();
    if(selectedimages!= null){
      setState(() {
        _images=selectedimages;
      });
    }
  }

  void setCustomMarkericon(){
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty,"assets/images/google.png").then((icon){
      currenticon=icon;
    });
  }
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    Location location=Location();
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Location services are disabled")));
      serviceEnabled=await location.requestService();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    location.onLocationChanged.listen((newloc){
      setState(() {
        _currentPosition=newloc as LatLng;
      });
    });
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Free food',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 1.0,
      ),
      body:
      _currentPosition==null ?Center(child: CircularProgressIndicator()):
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...? _images?.map((images){
                      return Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            margin: EdgeInsets.only(left: 5,right: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey
                              ),
                              image: DecorationImage(
                                image: FileImage(File(images.path)),
                                fit: BoxFit.cover
                              )
                            ),
                          ),
                          Positioned(
                            right:5,
                              top: 0,
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    _images!.remove(images);
                                  });
                                },
                                child: Icon(Icons.close_rounded,color: Colors.black,),
                              ))
                        ],
                      );
                    }).toList(),
                    if(_images!.length<10)
                      GestureDetector(
                        onTap: _pickimages,
                       child: Container(
                         width: 100,
                         height: 100,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           border: Border.all(
                             color: Colors.grey
                           ),
                         ),
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Icon(Icons.camera_alt_rounded,color: Colors.grey,size: 50,),
                             Padding(
                               padding: const EdgeInsets.only(left: 10),
                               child: Text(
                                 'Add up to 10 images',
                                 style: TextStyle(color: Colors.grey),
                               ),
                             ),
                           ],
                         ),
                       ),
                      )
                  ]
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'e.g. 2 x tins of veg soup, BB Dec 2023',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text('Quantity',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
              SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: List<Widget>.generate(5, (index) {
                  return ChoiceChip(
                    label: Text('${index + 1}'),
                    selected: _selectedQuantity == index + 1 && !_isOtherSelected,
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedQuantity = selected ? index + 1 : _selectedQuantity;
                        _isOtherSelected = false;
                      });
                    },
                  );
                }).toList()
                  ..add(
                    ChoiceChip(
                      label: Text('Other'),
                      selected: _isOtherSelected,
                      onSelected: (bool selected) {
                        setState(() {
                          _isOtherSelected = selected;
                          if (selected) {
                            _selectedQuantity = -1;
                          }
                        });
                      },
                    ),
                  ),
              ),
              if (_isOtherSelected)
                TextField(
                  controller: _otherQuantityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Others',
                    hintText: 'Others',
                    border: OutlineInputBorder(),
                  ),
                ),
              SizedBox(height: 20),
              TextField(
                controller: _pickupInstructionsController,
                decoration: InputDecoration(
                  labelText: 'Pick-up instructions',
                  hintText: 'e.g. "Pick up today from 4-6pm. Please ring doorbell when here."',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text('Your location (approx)'),
                trailing: Icon(Icons.location_on_rounded),
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>PickupLocationScreen()));
                  _getCurrentLocation();
                },
              ),
              SizedBox(height: 10),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: _currentPosition!,
                        zoom: 18.0,
                      ),
                      onMapCreated: (controller) {
                        // _controller = controller;
                      },
                      markers: {
                        Marker(
                          markerId: MarkerId('pickupLocation'),
                          // icon: currenticon,
                          position: _currentPosition!,
                        ),
                      },
                    ),
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text('List for'),
                trailing: _isListingDays ? Text('$_listingDays days',
                  style: TextStyle(fontSize: 14),) :Text('5 days',
                    style: TextStyle(fontSize: 14)),
                onTap: () {
                  // ListDays(context);
                  _SelectionDay(context);
                },
              ),
              Text(
                '👉 Food with a \'Use By\' date must be unlisted by midnight of the date.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isuploading ? null :_StoreFoodsData,
                  child:_isuploading ? CircularProgressIndicator():
                  Text('Submit',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _SelectionDay(BuildContext context) async{
    final int? selectedDay=await
    showDialog<int>(
        context: context, builder: (BuildContext context)=>Dialog.fullscreen(
        child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 15),
          Text(
            'Select days for listing:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Expanded(
              child:ListView.builder(
                itemCount: 30,
                  itemBuilder: (context,index){
                  return ListTile(
                    title: Text("${index+1} Days"),
                    onTap: (){
                      Navigator.pop(context,index+1);
                    },
                  );
                  })
          )
        ],
      ),
    ));
    if(selectedDay!=null){
      setState(() {
        _listingDays=selectedDay;
        _isListingDays = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Your Food Listing will be visible for $_listingDays"))
      );
    }
  }
}