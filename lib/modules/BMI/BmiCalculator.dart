import 'dart:math';

import 'package:first_app/modules/BMI/Bmi_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BmiCalculator extends StatefulWidget {
  @override
  _BmiCalculatorState createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  bool isFemale = true;
  int age = 20;
  int weight = 20;
  double height = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isFemale = false;
                              });
                            },
                            child: Container(
                              decoration: !isFemale
                                  ? boxDecorationSelectedGender()
                                  : boxDecoration(),
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 16),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.tram_outlined,
                                    size: 50,
                                  ),
                                  Text(
                                    "MALE",
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isFemale = true;
                              });
                            },
                            child: Container(
                              decoration: isFemale
                                  ? boxDecorationSelectedGender()
                                  : boxDecoration(),
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 16),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.tram_outlined,
                                    size: 50,
                                  ),
                                  Text(
                                    "WOMAN",
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                      decoration: boxDecoration(),
                      child: Column(children: [
                        Text(
                          "HEIGHT",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                "${height.round()}",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "CM",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ]),
                        Slider(
                            value: height,
                            min: 10,
                            max: 100,
                            onChanged: (value) {
                              height = value.roundToDouble();
                              setState(() {});
                              print(value.round());
                            })
                      ]),
                    ),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: boxDecoration(),
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 16),
                            child: Column(
                              children: [
                                Text(
                                  "AGE",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "$age",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: FloatingActionButton(
                                          mini: true,
                                          heroTag: 'age+',
                                          onPressed: () {
                                            setState(() {});
                                            age++;
                                          },
                                          child: Icon(Icons.add)),
                                    ),
                                    Expanded(
                                      child: FloatingActionButton(
                                          mini: true,
                                          heroTag: 'age-',
                                          onPressed: () {
                                            setState(() {});
                                            age--;
                                          },
                                          child: Icon(Icons.remove)),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Container(
                            decoration: boxDecoration(),
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 16),
                            child: Column(
                              children: [
                                Text(
                                  "WEIGHT",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${weight}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: FloatingActionButton(
                                          mini: true,
                                          heroTag: 'weight+',
                                          onPressed: () {
                                            weight++;
                                            setState(() {});
                                          },
                                          child: Icon(Icons.add)),
                                    ),
                                    Expanded(
                                      child: FloatingActionButton(
                                          mini: true,
                                          heroTag: 'weight-',
                                          onPressed: () {
                                            weight--;
                                            setState(() {});
                                          },
                                          child: Icon(Icons.remove)),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.blue[300],
            width: double.infinity,
            height: 50.0,
            child: MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BMIResultScreen(
                            age: age,
                            isMale: !isFemale,
                            result: (weight / pow(height / 100, 2)).round())));
              },
              child: Text("Calculate",
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
          )
        ],
      ),
    );
  }

  BoxDecoration boxDecorationSelectedGender() => BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue[300],
      );

  BoxDecoration boxDecoration() => BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[300],
      );
}
