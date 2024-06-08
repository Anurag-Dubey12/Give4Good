import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PickupLocationScreen extends StatefulWidget {
  @override
  _PickupLocationScreenState createState() => _PickupLocationScreenState();
}

class _PickupLocationScreenState extends State<PickupLocationScreen> {
  GoogleMapController? _controller;
  LatLng? _currentPosition;
  TextEditingController _searchController = TextEditingController();
  BitmapDescriptor currenticon=BitmapDescriptor.defaultMarker;
  final String _googleApiKey='AIzaSyDOiOhOwK631sfLNlZcYvPdul6PQimexhw';
  List<dynamic> _placePredictions = [];

  void setCustomMarkericon(){
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,"assets/images/google.png").then((icon){
       currenticon=icon;
    });
  }
  @override
  void initState() {
    super.initState();
    setCustomMarkericon();
    _getCurrentLocation();
  }
  Future<void> _searchLocation(String query) async {
    final url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$_googleApiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        _placePredictions = json.decode(response.body)['predictions'];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error fetching suggestions")));
    }
  }
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    Location location=Location();
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Disable")));
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

  Future<void> _selectPrediction(String placeId) async {
    final url = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$_googleApiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final location = json.decode(response.body)['result']['geometry']['location'];
      final LatLng selectedLocation = LatLng(location['lat'], location['lng']);

      setState(() {
        _currentPosition = selectedLocation;
        _placePredictions = [];
      });

      _controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: selectedLocation,
        zoom: 14.0,
      )));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error fetching location details")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose pickup location', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _currentPosition == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _currentPosition!,
              zoom: 14.0,
            ),
            onMapCreated: (controller) {
              _controller = controller;
            },
            markers: {
              Marker(
                markerId: MarkerId('pickupLocation'),
                position: _currentPosition!,
              ),
            },
          ),
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search here',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            _searchLocation(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _placePredictions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_placePredictions[index]['description']),
                      onTap: () {
                        _selectPrediction(_placePredictions[index]['place_id']);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 100,
            right: 16,
            child: FloatingActionButton(
              onPressed: _getCurrentLocation,
              backgroundColor: Colors.purple,
              child: Icon(Icons.my_location, color: Colors.white),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                // Handle location selection
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Set pickup location',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}