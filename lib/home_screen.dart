import 'dart:math';

import 'package:bmi_calculate_app2/age_weight_widget.dart';
import 'package:bmi_calculate_app2/gender_widget.dart';
import 'package:bmi_calculate_app2/height_widget.dart';
import 'package:bmi_calculate_app2/main.dart';
import 'package:bmi_calculate_app2/score_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _gender = 0;
  int _height = 150;
  int _age = 30;
  int _weight = 50;
  bool _isFinished = false;
  double _bmiScore =0;


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
                  },
                ),
                HeightWidget(onChange: (heightVal){
                  _height = heightVal;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AgeWeightWidget(
                        onChange: (ageVal) {
                          _age = ageVal;
                        },
                        initValue: 30,
                        max: 100,
                        min: 0,
                        title: "Age"),
                    AgeWeightWidget(
                        onChange: (weightVal) {
                          _weight = weightVal;
                        },
                        initValue: 50,
                        max: 200,
                        min: 0,
                        title: "Weight(Kg)"),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20, horizontal: 60),
                  child: SwipeableButtonView(
                      isFinished: _isFinished,
                      onFinish: () async {
                        await Navigator.push(context,
                        PageTransition(
                            child: ScoreScreen(
                              bmiScore: _bmiScore,
                              age: _age,
                            ), type: PageTransitionType.fade));

                        setState(() {
                          _isFinished = false;
                        });
                      },
                      onWaitingProcess: (){
                        // Calculate BMI here
                        calculateBmi();

                        Future.delayed(Duration(seconds: 1),(){
                          setState(() {
                            _isFinished = true;
                          });
                        });
                      },
                      activeColor: Colors.blue,
                      buttonWidget: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                      ),
                      buttonText: "CALCULATE"),
                )
              ],
            ),
          ),
        ),
      ));
  }
  void calculateBmi(){
    _bmiScore = _weight / pow(_height / 100, 2);
  }
}
