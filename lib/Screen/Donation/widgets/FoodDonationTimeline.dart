
import 'package:flutter/material.dart';

class Fooddonationtimeline extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: Drawer(
          elevation: 16,
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Donation Summary',
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Container(
            width: 396,
            height: 614,
            decoration: BoxDecoration(
            ),
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional(0, -1),
                  child: Container(
                    width: 439,
                    height: 170,
                    decoration: BoxDecoration(
                      color: Color(0xFF09E9F6),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.07, -0.76),
                  child: Material(
                    color: Colors.transparent,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Container(
                      width: 297,
                      height: 184,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0, -1),
                            child: Container(
                              width: 100,
                              height: 100,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.network(
                                'https://picsum.photos/seed/96/600',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            'Hello World',
                          ),
                          Text(
                            'Hello World',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-0.87, -0.05),
                  child: Text(
                    'Hello World',
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-0.38, 0.27),
                  child: Container(
                    width: 386,
                    height: 100,
                    decoration: BoxDecoration(

                    ),
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