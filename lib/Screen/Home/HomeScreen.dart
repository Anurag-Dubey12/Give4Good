import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:give4good/Screen/Donation/FoodScreen.dart';
import 'package:give4good/Screen/Donation/NonFoodScreen.dart';
import 'package:give4good/Screen/Donation/WantedScreen.dart';
import 'package:give4good/Screen/Home/HistoryScreen.dart';
import 'package:give4good/Screen/Home/DonateScreenWidgets.dart';
import 'package:give4good/Screen/Home/HomeScreenWidgets.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
class Homescreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>homescreen();
}
class homescreen extends State<Homescreen>{
  var padding = EdgeInsets.symmetric(horizontal: 18, vertical: 5);
  int _index = 0;
  List<Color> colors = [
    Colors.purple,
    Colors.pink,
    Colors.blue,
    Colors.teal
  ];
  List<Widget> screens = [
    Homescreenwidgets(),
    Donatescreenwidgets(),
    // Fundraiserscreenwidgets(),
    HistoryScreen()
  ];
  PageController controller = PageController();

  void _showBottomSheet(BuildContext context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return Padding(
              padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                CategoryItem(
                  icon: Icons.local_dining,
                  iconColor: Colors.purple,
                  title: 'Food',
                  subtitle: 'Give away anything you would eat yourself',
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder:(context)=>Foodscreen()));
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
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder:(context)=>Nonfoodscreen()));
                  },
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey,
                ),
                CategoryItem(
                  icon: Icons.speaker_phone,
                  iconColor: Colors.red,
                  title: 'Wanted',
                  subtitle: 'Ask for Something',
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder:(context)=>Wantedscreen()));
                  },
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
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
      backgroundColor: Colors.white,
      body: PageView.builder(
        itemCount: 4,
        controller: controller,
        onPageChanged: (page) {
          setState(() {
            _index = page;
          });
        },
        itemBuilder: (context, position) {
          return Container(
            color: colors[position],
            child: Center(child: screens[position]),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 50,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(100)),
            boxShadow: [
              BoxShadow(
                spreadRadius: -10,
                blurRadius: 60,
                color: Colors.black.withOpacity(0.4),
                offset: Offset(0, 25),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
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
                // GButton(
                //   gap: 10,
                //   icon: LineIcons.search,
                //   iconColor: Colors.black,
                //   iconActiveColor: Colors.black,
                //   text: 'Fundraiser',
                //   textColor: Colors.black,
                //   backgroundColor: Colors.grey.withOpacity(0.2),
                //   iconSize: 24,
                //   padding: padding,
                // ),
                GButton(
                  gap: 10,
                  icon: LineIcons.history,
                  iconColor: Colors.black,
                  iconActiveColor: Colors.teal,
                  text: 'History',
                  textColor: Colors.teal,
                  backgroundColor: Colors.teal.withOpacity(0.2),
                  iconSize: 24,
                  padding: padding,
                ),
              ],
              selectedIndex: _index,
              onTabChange: (index) {
                setState(() {
                  _index = index;
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
class CategoryItem extends StatelessWidget{
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  CategoryItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
});
  @override
  Widget build(BuildContext context) {
   return ListTile(
     leading: CircleAvatar(
       backgroundColor: iconColor,
       child: Icon(icon,color: Colors.white,),
     ),
     title: Text(title,style: TextStyle(fontWeight: FontWeight.bold)),
     subtitle: Text(subtitle),
     onTap: onTap,
   );
  }
}