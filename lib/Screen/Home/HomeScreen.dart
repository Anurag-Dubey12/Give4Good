
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:give4good/Screen/Home/AboutScreenWidgets.dart';
import 'package:give4good/Screen/Home/DonateScreenWidgets.dart';
import 'package:give4good/Screen/Home/FundraiserScreenWidgets.dart';
import 'package:give4good/Screen/Home/HomeScreenWidgets.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
class Homescreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>homescreen();
}
class homescreen extends State<Homescreen>{
  var padding = EdgeInsets.symmetric(horizontal: 18,vertical: 5);
  int _index=0;
  List<Color> colors = [
    Colors.purple,
    Colors.pink,
    Colors.blue,
    Colors.teal
  ];
  List<Widget> screens=[
    Homescreenwidgets(),
    Donatescreenwidgets(),
    Fundraiserscreenwidgets(),
    Aboutscreenwidgets()
  ];
  PageController controller =PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text('Give4Goods',style: TextStyle(color: Colors.black),),
      ),
      backgroundColor: Colors.white,
      body: PageView.builder(
          itemCount: 4,
          controller: controller,
          onPageChanged: (page){
            setState(() {
              _index=page;
            });
          },
        itemBuilder: (context,position){
            return Container(
              color:colors[position],
              child: Center(child: screens[position],),
            );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(100)),
            boxShadow: [
              BoxShadow(
                spreadRadius: -10,
                blurRadius: 60,
                color: Colors.black.withOpacity(0.4),
                offset: Offset(0,25)
              )
            ]
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 3),
            child: GNav(
              haptic: true,
              curve: Curves.fastOutSlowIn,
              duration: Duration(milliseconds: 900),
              tabs: [
                GButton(
                  gap: 10,
                  icon: LineIcons.home,
                  iconColor: Colors.black,
                  iconActiveColor: Colors.purple,
                  text: 'Home',
                  textColor: Colors.purple,
                  backgroundColor: Colors.purple.withOpacity(0.2),
                  iconSize: 24,
                  padding: padding,
                ),
                GButton(
                  gap: 10,
                  icon: LineIcons.donate,
                  iconColor: Colors.black,
                  iconActiveColor: Colors.pink,
                  text: 'Donate',
                  textColor: Colors.pink,
                  backgroundColor: Colors.pink.withOpacity(0.2),
                  iconSize: 24,
                  padding: padding,
                ),
                GButton(
                  gap: 10,
                  icon: LineIcons.search,
                  iconColor: Colors.black,
                  iconActiveColor: Colors.grey,
                  text: 'Fundraiser',
                  textColor: Colors.grey,
                  backgroundColor: Colors.grey.withOpacity(0.2),
                  iconSize: 24,
                  padding: padding,
                ),
                GButton(
                  gap: 10,
                  icon: LineIcons.user,
                  iconColor: Colors.black,
                  iconActiveColor: Colors.teal,
                  text: 'About',
                  textColor: Colors.teal,
                  backgroundColor: Colors.teal.withOpacity(0.2),
                  iconSize: 24,
                  padding: padding,
                ),
              ],
              selectedIndex: _index,
              onTabChange: (index){
                setState(() {
                  _index =index;
                });
                controller.jumpToPage(index);
              },
            ),
          ),
        ),
      ),
    );
  }

}