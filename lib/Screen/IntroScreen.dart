import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:give4good/Screen/Auth/AuthScreen.dart';
import 'package:give4good/Screen/Auth/AuthScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'Onboarding/Onboarding_items.dart';

class Introscreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IntroState();
}

class _IntroState extends State<Introscreen> {
  final controller =OnboardingItems();
  final pageController=PageController();
  bool isLastPage=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: isLastPage? getStarted() : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: ()=>pageController.jumpToPage(controller.items.length-1),
                child: Text("Skip",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),)),
            SmoothPageIndicator(
                controller: pageController,
                count: controller.items.length,
                onDotClicked: (index)=>pageController.animateToPage(index,
                duration: Duration(microseconds: 600),curve: Curves.easeInCirc),
                effect: WormEffect(
                  dotHeight: 12,
                  dotWidth: 12,
                  activeDotColor: Colors.purple
              ),
            ),
            TextButton(
                onPressed: ()=>pageController.nextPage(
                  duration: Duration(microseconds: 600),curve: Curves.easeIn,
                ),
                child: Text("Next",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),))
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
          onPageChanged: (index)=>setState(()=>isLastPage=controller.items.length-1==index),
          itemCount: controller.items.length,
          controller: pageController,
          itemBuilder: (context,index){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(controller.items[index].image),
                const SizedBox(height: 15),
                Text(controller.items[index].title,
                  style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                const SizedBox(height: 15),
                Text(controller.items[index].descriptions,
                    style: const TextStyle(color: Colors.grey,fontSize: 17), textAlign: TextAlign.center)
              ],
            );
          },
        ),
      ),
    );
}

  Widget getStarted(){
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.purple
      ),
      width: MediaQuery.of(context).size.width * .9,
      height: 55,
      child: TextButton(
          onPressed: ()async{
            final pres = await SharedPreferences.getInstance();
            pres.setBool("onboarding", true);
            if(!mounted)return;
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Authscreen()));
          },
          child: const Text("Get started",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
    );
  }
}
