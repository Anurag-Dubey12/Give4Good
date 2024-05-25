import 'package:flutter/material.dart';

class Fundbeneficiaryscreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BeneficiaryScreenState();
}

class BeneficiaryScreenState extends State<Fundbeneficiaryscreen> {
  String? selectedPurpose;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Beneficiary Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select the purpose of the fundraiser:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: selectedPurpose ?? 'Select Purpose',
                suffixIcon: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    icon: Icon(Icons.arrow_drop_down),
                    value: selectedPurpose,
                    hint: Text('Select Purpose'),
                    items: <String>['Myself', 'Family', 'Friend', 'Others', 'NGO']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedPurpose = newValue;
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // if (selectedPurpose == 'Myself')
            //   MyselfScreen()
            // else if (selectedPurpose == 'Family')
            //   FamilyScreen()
            // else if (selectedPurpose == 'Friend')
            //     FriendScreen()
            //   else if (selectedPurpose == 'Others')
            //       OthersScreen()
            //     else if (selectedPurpose == 'NGO')
            //         NGOScreen(),
            SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (selectedPurpose != null) {
                    print('Selected Purpose: $selectedPurpose');
                    // Navigate to the next screen or perform an action based on the selected purpose
                  } else {
                    print('Please select a purpose!');
                  }
                },
                child: Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}