import 'package:bmi_calculate_app2/gender_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _gender = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("BMI Calculate"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Card(
            elevation: 12,
            shape: const RoundedRectangleBorder(),
            child: Column(
              children: [
                // Let's create widget for gender selection
                GenderWidget(onChange: (genderVal){
                  _gender = genderVal;
                },)
              ],
            ),
          ),
        ),
      ));
  }
}
