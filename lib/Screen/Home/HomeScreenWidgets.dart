
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:give4good/Screen/Auth/Signin.dart';
import 'package:give4good/Screen/Donation/widgets/DonationWidget.dart';
import 'package:give4good/Screen/Donation/widgets/FundraiserCard.dart';
import 'package:give4good/Screen/Donation/widgets/NGOsWidgets.dart';
import 'package:give4good/Screen/Home/DonateScreenWidgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:line_icons/line_icons.dart';

class Homescreenwidgets extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>home();

}
class home extends State<Homescreenwidgets>{
  TextEditingController _searchController=TextEditingController();

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
        backgroundColor: Colors.white,
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton:Padding(
          padding: const EdgeInsets.only(bottom:60),
          child: FloatingActionButton(
            onPressed: () {
              _showBottomSheet(context);
            },
            mini: true,
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
          title: Text("Give4Goods",style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.teal,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(onPressed: (){},icon: Icon(Icons.notifications,color: Colors.white,)),
            IconButton(onPressed: (){},icon: Icon(Icons.location_on,color: Colors.white,)),
            Builder(builder: (context){
              return IconButton(
                  onPressed: (){
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: Icon(Icons.menu,color: Colors.white,));
            })
          ],
        ),
        body:SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: EdgeInsets.only(left: 10,bottom:100,right: 10),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 400,
                      child: Column(
                        children: [
                          SizedBox(height: 16),
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
                                      hintText: 'Search NGO Here',
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (value) {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // ListView.builder(
                          //   shrinkWrap: true,
                          //   itemCount: 2,
                          //   itemBuilder: (context, index) {
                          //     return ListTile(
                          //       title: Text(''),
                          //       onTap: () {
                          //         // _selectPrediction(_placePredictions[index]['place_id']);
                          //       },
                          //     );
                          //   },
                          // ),
                        ],

                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Container(
                  margin: EdgeInsets.symmetric(horizontal:10),
                  width: double.infinity,
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(10),
                  //   border: Border.all(
                  //     color: Colors.grey,
                  //     width: 2
                  //   ),
                  // ),
                  child: Row(
                        children: [
                          CategoryButton(
                            icon: Icons.apps,
                            label: 'Categories',
                            onPressed: (){},
                          ),
                          SizedBox(width: 20,),
                          CategoryButton(
                            icon: Icons.checkroom,
                            label: 'Clothes',
                            onPressed: (){},
                          ),
                          SizedBox(width: 20,),
                          CategoryButton(
                            icon: Icons.fastfood,
                            label: 'Food',
                            onPressed: (){},
                          ),
                          SizedBox(width: 20,),
                          CategoryButton(
                            icon: Icons.book,
                            label: 'Education',
                            onPressed: (){},
                          ),
                        ],
                      ),
                  ),
                SizedBox(height: 10,),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/images/hungry.jpg",
                        width: 400,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "We can do \nsmall things with great love",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "See Active Campaigns",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ListTile(
                  leading: Text("Helping NGOs ",style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),),
                  trailing: Text("See all",
                    style: TextStyle(
                      color: Colors.teal,
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                    ),),
                  onTap: (){
                    // Navigator.pushReplacement(
                    //     context, MaterialPageRoute(builder: (BuildContext context)=>Donatescreenwidgets()));
                  },
                ),
               SingleChildScrollView(
                 scrollDirection: Axis.horizontal,
                 child: Row(
                   children: [
                     Ngoswidgets(
                       image: "assets/images/hungry.jpg",
                       NgoName: 'Smile Foundation',
                       NgoLocation: 'Galaxy Tower,Lucknow',
                       NgoRating: "4.5",
                       tag: ["2.4km","Childern Charity"],
                       onTap: (){},
                     ),
                     Ngoswidgets(
                       image: "assets/images/hungry.jpg",
                       NgoName: 'AgeWell Foundation',
                       NgoLocation: 'Galaxy Tower,Lucknow',
                       NgoRating: "4.5",
                       tag: ["2km","Old Age  Charity"],
                       onTap: (){},
                     ),
                     Ngoswidgets(
                       image: "assets/images/hungry.jpg",
                       NgoName: 'Well Goods Foundation',
                       NgoLocation: 'Paradise Tower,Thane',
                       NgoRating: "3.2",
                       tag: ["5.6km","Cloths Charity"],
                       onTap: (){},
                     ),
                     Ngoswidgets(
                       image: "assets/images/hungry.jpg",
                       NgoName: 'NoWaste Foundation',
                       NgoLocation: 'Fancy Park Tower,Delhi',
                       NgoRating: "4.2",
                       tag: ["2.4km","Books Charity"],
                       onTap: (){},
                     ),
                     Ngoswidgets(
                       image: "assets/images/hungry.jpg",
                       NgoName: 'Well Goods Foundation',
                       NgoLocation: 'Paradise Tower,Thane',
                       NgoRating: "3.2",
                       tag: ["5.6km","Cloths Charity"],
                       onTap: (){},
                     ),
                     Ngoswidgets(
                       image: "assets/images/hungry.jpg",
                       NgoName: 'AgeWell Foundation',
                       NgoLocation: 'Galaxy Tower,Lucknow',
                       NgoRating: "4.5",
                       tag: ["2km","Old Age  Charity"],
                       onTap: (){},
                     ),
                   ],
                 ),
               ),
                ListTile(
                  leading: Text("Urgent Needs ",style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),),
                  trailing: Text("See all",
                    style: TextStyle(
                        color: Colors.teal,
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                    ),),
                  onTap: (){
                    // Navigator.pushReplacement(
                    //     context, MaterialPageRoute(builder: (BuildContext context)=>Donatescreenwidgets()));
                  },
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                     FundraiserCard(
                         image:  "assets/images/hungry.jpg",
                         title: "Help for riyan Surgery",
                         amountRaised: 4000,
                         totalAmount: 40000,
                         donors: 150,
                         daysLeft: 3,
                       onPressed: () {  },

                     ),
                      FundraiserCard(
                          image:  "assets/images/hungry.jpg",
                          title: "Help for riyan Surgery",
                          amountRaised: 4000,
                          totalAmount: 4000,
                          donors: 150,
                          daysLeft: 3,
                        onPressed: () {  },
                      ),
                      FundraiserCard(
                          image:  "assets/images/hungry.jpg",
                          title: "Help for riyan Surgery",
                          amountRaised: 4000,
                          totalAmount: 4000,
                          donors: 150,
                          daysLeft: 3,
                        onPressed: () {  },
                      ),
                      FundraiserCard(
                          image:  "assets/images/hungry.jpg",
                          title: "Help for riyan Surgery",
                          amountRaised: 4000,
                          totalAmount: 40000,
                          donors: 150,
                          daysLeft: 3,
                        onPressed: () {  },
                      ),
                      FundraiserCard(
                          image:  "assets/images/hungry.jpg",
                          title: "Help for riyan Surgery",
                          amountRaised: 4000,
                          totalAmount: 4000,
                          donors: 150,
                          daysLeft: 3,
                          onPressed: () {  },
                      ),
                      FundraiserCard(
                          image:  "assets/images/hungry.jpg",
                          title: "Help for riyan Surgery",
                          amountRaised: 4000,
                          totalAmount: 4000,
                          donors: 150,
                          daysLeft: 3,
                        onPressed: () {  },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class CategoryButton extends StatelessWidget{
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  CategoryButton({required this.label,required this.icon,required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.teal,
          child: IconButton(
            icon: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              // Handle button press
            },
          ),
        ),
        SizedBox(height: 8),
        Text(label),
      ],
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