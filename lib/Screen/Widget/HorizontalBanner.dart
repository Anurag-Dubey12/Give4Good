
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Horizontalbanner extends StatefulWidget{
  List<String> banner=[];
  Horizontalbanner({required this.banner});
  @override
  State<StatefulWidget> createState() =>horizontal();
}
class horizontal extends State<Horizontalbanner>{


  ScrollController _scrollController=ScrollController();
  double _scrollpos=0;

  @override
  void initState() {
    Timer.periodic(Duration(milliseconds: 30), (Timer timer){
      setState(() {
        _scrollpos+=1;
        if(_scrollpos>=_scrollController.position.maxScrollExtent){
          _scrollpos=0;
        }
        _scrollController.jumpTo(_scrollpos);
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(10)
      ),
      height: 50,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: widget.banner.length,
          itemBuilder: (context,index){
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
               widget.banner[index],
               style: TextStyle(fontSize: 18,color: Colors.white),
              )
            );
          }),
    );
  }

}