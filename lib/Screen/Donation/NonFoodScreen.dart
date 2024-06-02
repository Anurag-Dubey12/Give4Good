
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Nonfoodscreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> nonfoodscreen();
}
class nonfoodscreen extends State<Nonfoodscreen>{
  int _selectedQuantity = 1;
  bool _isOtherSelected = false;

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {

                },
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt, color: Colors.grey, size: 50),
                      Text(
                        'Add up to 10 images',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'e.g. 2 x tins of veg soup, BB Dec 2023',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text('Quantity'),
              SizedBox(height: 5),
              Text(
                '(this calculates your impact 🌍)',
                style: TextStyle(color: Colors.blue, fontSize: 12),
              ),
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
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Others',
                    hintText: 'Others',
                    border: OutlineInputBorder(),
                  ),
                ),
              SizedBox(height: 20),
              TextField(
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
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {

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
                  child: Text(
                    'Map Placeholder',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text('List for'),
                trailing: Text('5 days'),
                onTap: () {
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
                  onPressed: () {

                  },
                  child: Text('Submit',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15)),
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
}