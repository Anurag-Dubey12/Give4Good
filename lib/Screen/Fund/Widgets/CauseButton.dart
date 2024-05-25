
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Causebutton extends StatelessWidget{
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  Causebutton({required this.text,required this.isSelected,required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey,
              width: 2
          )
        ),
        child: Text(
          text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )
        ),
      ),
    );
  }

}