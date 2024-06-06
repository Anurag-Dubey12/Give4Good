import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:give4good/Screen/Donation/widgets/PickupLocationScreen.dart';
import 'package:image_picker/image_picker.dart';

class Foodscreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> foodscreen();
}
class foodscreen extends State<Foodscreen>{
  int _selectedQuantity = 1;
  bool _isOtherSelected = false;
  List<XFile>? _images=[];
  bool _isuploading=false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _pickupInstructionsController = TextEditingController();
  final TextEditingController _otherQuantityController = TextEditingController();

  Future<void> _pickimages()async{
    final List<XFile> selectedimages=await ImagePicker().pickMultiImage();
    if(selectedimages!= null){
      setState(() {
        _images=selectedimages;
      });
    }
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
      body:Padding(
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
                            right:0,
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
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PickupLocationScreen()));
                  },
                  child: Center(
                    child: Text(
                      'Map Placeholder',
                      style: TextStyle(color: Colors.grey),
                    ),
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