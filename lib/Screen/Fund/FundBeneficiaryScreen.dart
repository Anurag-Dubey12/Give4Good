import 'package:flutter/material.dart';

class Fundbeneficiaryscreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BeneficiaryScreenState();
}

class BeneficiaryScreenState extends State<Fundbeneficiaryscreen> {
  String? selectedPurpose;
  int currentstep=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Beneficiary Details"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Stepper(
                type: StepperType.horizontal,
                steps: getSteps(),
              currentStep: currentstep,
              onStepContinue: (){
                  final islastpage=currentstep==getSteps().length-1;
                  if(islastpage){
                    print("Completed");
                  }else{

                  setState(() {
                    currentstep+=1;
                  });
                  }
              },
              onStepCancel: (){
                  currentstep==0 ? null :()=> setState(() {
                    currentstep-=1;
                  });
              },
            ),
      )
    );
  }
  List<Step> getSteps()=>[
    Step(
      isActive: currentstep>=0,
        title: Text("Basic Details"),
        content: Container()),
    Step(
        isActive: currentstep>=1,
        title: Text("Basic Details"),
        content: Container()),
    Step(
        isActive: currentstep>=2,
        title: Text("Basic Details"),
        content: Container()),
    Step(
        isActive: currentstep>=4,
        title: Text("Basic Details"),
        content: Container()),
    Step(
        isActive: currentstep>=5,
        title: Text("Basic Details"),
        content: Container()),
    Step(
        isActive: currentstep>=6,
        title: Text("Basic Details"),
        content: Container()),
  ];
}