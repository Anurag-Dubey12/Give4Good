import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:give4good/Screen/Donation/FoodScreen.dart';
import 'package:give4good/Screen/Donation/NonFoodScreen.dart';
import 'package:give4good/Screen/Donation/WantedScreen.dart';
import 'package:give4good/Screen/Home/HistoryScreen.dart';
import 'package:give4good/Screen/Home/DonateScreenWidgets.dart';
import 'package:give4good/Screen/Home/HomeScreenWidgets.dart';
import 'package:get/get.dart';

import '../Donation/widgets/CategoryItem.dart';

class Homescreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>homescreen();
}
class homescreen extends State<Homescreen>{
  int _index = 0;
  List<Widget> screens = [
    Homescreenwidgets(),
    Donatescreenwidgets(),
    HistoryScreen()
  ];
  PageController controller = PageController();

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CategoryItem(
                  icon: Icons.local_dining,
                  iconColor: Colors.purple,
                  title: 'Food',
                  subtitle: 'Give away anything you would eat yourself',
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Foodscreen()));
                  },
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey,
                ),
                CategoryItem(
                  icon: Icons.cleaning_services,
                  iconColor: Colors.pink,
                  title: 'Non-food',
                  subtitle: 'Give away toiletries, cosmetics, kitchen utensils, toys, clothes etc',
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Nonfoodscreen()));
                  },
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey,
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _index == 1
          ? Padding(
        padding: const EdgeInsets.only(right: 15, bottom: 15),
        child: FloatingActionButton(
          onPressed: () {
            _showBottomSheet(context);
          },
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          hoverColor: Colors.purple,
          splashColor: Colors.yellow,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          tooltip: 'Donate Items',
          child: Icon(Icons.add),
          elevation: 2.0,

        ),
      )
          : null,
      backgroundColor: Colors.black,
      body: PageView.builder(
        itemCount: screens.length,
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (page) {
          setState(() {
            _index = page;
          });
        },
        itemBuilder: (context, position) {
          return screens[position];
        },
      ),
      bottomNavigationBar: Container(
        // margin: EdgeInsets.only(bottom: 2),
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: Colors.grey,
              width: 2,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0),
            topRight: Radius.circular(50.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: FlashyTabBar(
            backgroundColor: Colors.teal,
            selectedIndex: _index,
            showElevation: true,
            onItemSelected: (index) {
              setState(() {
                _index = index;
              });
              controller.jumpToPage(index);
            },
            items: [
              FlashyTabBarItem(
                icon: Icon(Icons.home),
                activeColor: Colors.white,
                inactiveColor: Colors.black,
                title: Text('Home'),
              ),
              FlashyTabBarItem(
                icon: Icon(Icons.favorite),
                activeColor: Colors.white,
                inactiveColor: Colors.black,
                title: Text('Donate'),
              ),
              FlashyTabBarItem(
                icon: Icon(Icons.history),
                activeColor: Colors.white,
                inactiveColor: Colors.black,
                title: Text('History'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

