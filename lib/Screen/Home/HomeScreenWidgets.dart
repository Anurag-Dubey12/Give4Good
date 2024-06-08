
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:give4good/Screen/Auth/Signin.dart';
class Homescreenwidgets extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>home();

}
class home extends State<Homescreenwidgets>{
  void _showBottomSheet(BuildContext context){
    String itemAddedBy = 'All';
    String itemAvailability = 'All';
    double maxDistance = 0.3;
    String sortBy = 'Newest';
    String location = 'Home';
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(
              builder: (BuildContext context,StateSetter setState){
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
                    SizedBox(height: 16,),
                    Center(
                      child: Text("Filter Options" ,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18)),
                    ),
                    Divider(height: 20,thickness: 1),
                    SizedBox(height: 10,),
                    Text("Item Added By",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        ChoiceChip(
                          label: Text('All'),
                          selected: itemAddedBy == 'All',
                          onSelected: (bool selected) {
                            setState(() {
                              itemAddedBy = 'All';
                            });
                          },
                        ),
                        SizedBox(width: 8),
                        ChoiceChip(
                          label: Text('Personal'),
                          selected: itemAddedBy == 'Personal',
                          onSelected: (bool selected) {
                            setState(() {
                              itemAddedBy = 'Personal';
                            });
                          },
                        ),
                        SizedBox(width: 8),
                        ChoiceChip(
                          label: Text('Volunteer'),
                          selected: itemAddedBy == 'Volunteer',
                          onSelected: (bool selected) {
                            setState(() {
                              itemAddedBy = 'Volunteer';
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16,),
                    Text("Item Availability",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        ChoiceChip(
                          label: Text('All'),
                          selected: itemAvailability == 'All',
                          onSelected: (bool selected) {
                            setState(() {
                              itemAvailability = 'All';
                            });
                          },
                        ),
                        SizedBox(width: 8),
                        ChoiceChip(
                          label: Text('Available Only'),
                          selected: itemAvailability == 'Available Only',
                          onSelected: (bool selected) {
                            setState(() {
                              itemAvailability = 'Available Only';
                            });
                          },
                        ),
                        SizedBox(width: 8),
                        ChoiceChip(
                          label: Text('Just Gone'),
                          selected: itemAvailability == 'Just Gone',
                          onSelected: (bool selected) {
                            setState(() {
                              itemAvailability = 'Just Gone';
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16,),
                    Text("Maximum Distance",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ChoiceChip(
                            label: Text('0.3 miles'),
                            selected: maxDistance == 0.3,
                            onSelected: (bool selected) {
                              setState(() {
                                maxDistance = 0.3;
                              });
                            },
                          ),
                          SizedBox(width: 8),
                          ChoiceChip(
                            label: Text('0.6 miles'),
                            selected: maxDistance == 0.6,
                            onSelected: (bool selected) {
                              setState(() {
                                maxDistance = 0.6;
                              });
                            },
                          ),
                          SizedBox(width: 8),
                          ChoiceChip(
                            label: Text('1.3 miles'),
                            selected: maxDistance == 1.3,
                            onSelected: (bool selected) {
                              setState(() {
                                maxDistance = 1.3;
                              });
                            },
                          ),
                          SizedBox(width: 8),
                          ChoiceChip(
                            label: Text('3 miles'),
                            selected: maxDistance == 3,
                            onSelected: (bool selected) {
                              setState(() {
                                maxDistance =3;
                              });
                            },
                          ),
                          SizedBox(width: 8),
                          ChoiceChip(
                            label: Text('6 miles'),
                            selected: maxDistance == 6,
                            onSelected: (bool selected) {
                              setState(() {
                                maxDistance =6;
                              });
                            },
                          ),
                          SizedBox(width: 8),
                          ChoiceChip(
                            label: Text('16 miles'),
                            selected: maxDistance == 16,
                            onSelected: (bool selected) {
                              setState(() {
                                maxDistance = 16;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16,),
                    Text(
                      'Sort by:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    RadioListTile(
                      title: Text("Newest"),
                        value: 'Newest',
                        groupValue: sortBy,
                        onChanged: (String? value){
                        setState(() {
                          sortBy=value!;
                        });
                        }),
                    RadioListTile(
                        title: Text("Closet"),
                        value: 'Closet',
                        groupValue: sortBy,
                        onChanged: (String? value){
                          setState(() {
                            sortBy=value!;
                          });
                        }),
                    SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                        ),
                        onPressed: () {
                          Navigator.pop(context, {
                            'itemAddedBy': itemAddedBy,
                            'itemAvailability': itemAvailability,
                            'maxDistance': maxDistance,
                            'sortBy': sortBy,
                            'location': location,
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            'Apply',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
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
    ).then((filters) {
      if (filters != null) {
        setState(() {
          print(filters);
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(

        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton:Padding(
          padding: const EdgeInsets.only(right: 15, bottom: 100),
          child: FloatingActionButton(
            onPressed: () {
              _showBottomSheet(context);
            },
            foregroundColor: Colors.white,
            backgroundColor: Colors.black,
            hoverColor: Colors.purple,
            splashColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
            tooltip: 'Filters',
            child: Icon(Icons.filter_list),
            elevation: 2.0,
          ),
        ),
        endDrawer: Container(
          margin: EdgeInsets.only(bottom: 100,top: 30),
          child: Drawer(
            backgroundColor: Colors.white,
            child: ListView(
              children: <Widget>[
               Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('assets/images/logo.png'),
              ),
              SizedBox(height: 10),
              Text(
                'Anurag',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ],
          ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.list),
                  title: Text('My Listings'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text('Account'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text('Notification Settings'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text('Location'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.help),
                  title: Text('About Us'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.logout_rounded),
                  title: Text('Logout'),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content:Text("Logout Successfully")));
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Signin()));
                  },
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: Text("Give4Goods"),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(onPressed: (){},icon: Icon(Icons.notifications)),
            IconButton(onPressed: (){},icon: Icon(Icons.search)),
            // IconButton(onPressed: (){},icon: Icon(Icons.location_on)),
            Builder(builder: (context){
              return IconButton(
                  onPressed: (){
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: Icon(Icons.menu));
            })

          ],

          bottom: TabBar(
            indicatorColor: Colors.green,
            automaticIndicatorColorAdjustment: true,
            tabs: [
              Tab(text: "Food",),
              Tab(text: "Non-Food",)
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FoodTabContent(),
            NonFoodTabContent(),
          ],
        ),
      ),
    );
  }
}
class FoodTabContent extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NoListingsSection(),
        Spacer(),
      ],
    );
  }
}
class NonFoodTabContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NoListingsSection(),
        Spacer(),
      ],
    );
  }
}
class NoListingsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        "No listings near you right now - why not add something?",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}