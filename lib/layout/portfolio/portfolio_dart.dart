import 'package:first_app/layout/home_layout/home_layout.dart';
import 'package:first_app/layout/news_layout/news_layout.dart';
import 'package:first_app/layout/todo_layout/home_layout.dart';
import 'package:first_app/modules/BMI/BmiCalculator.dart';
import 'package:first_app/modules/shop_app/login/login_screen.dart';
import 'package:first_app/modules/shop_app/on_boarding/on_boarding.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/components/constants.dart';
import 'package:first_app/shared/network/local/shared_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Portfolio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text("Portfolio"),
        ),
        body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
              ),
              Expanded(
                child: Center(
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(children: [
                          Container(
                            child: Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        navigateTo(
                                            context: context,
                                            widget: setShopHomeScreen());
                                      },
                                      child: Container(
                                        decoration: boxDecoration(),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 16),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                                "assets/images/shop.png"),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Text(
                                              "Shop App",
                                              style: TextStyle(
                                                  fontSize: 18,
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
                                        navigateTo(
                                            context: context,
                                            widget: TodoHomeLayout());
                                      },
                                      child: Container(
                                        decoration: boxDecoration(),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 16),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/images/to_do_list.png",
                                              height: 65,
                                            ),
                                            SizedBox(
                                              height: 25,
                                            ),
                                            Text(
                                              "Todo App",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            child: Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        navigateTo(
                                            context: context,
                                            widget: NewsLayout());
                                      },
                                      child: Container(
                                        decoration: boxDecoration(),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 16),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                                "assets/images/newspaper.png"),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Text(
                                              "News App",
                                              style: TextStyle(
                                                  fontSize: 18,
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
                                        navigateTo(
                                            context: context,
                                            widget: BmiCalculator());
                                      },
                                      child: Container(
                                        decoration: boxDecoration(),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 16),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/images/bmi.png",
                                              height: 65,
                                            ),
                                            SizedBox(
                                              height: 25,
                                            ),
                                            Text(
                                              "BMI App",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]))),
              ),
              SizedBox(
                height: 80,
              ),
            ]));
  }
}

BoxDecoration boxDecoration() => BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(2, 3), // changes position of shadow
        ),
      ],
    );

Widget setShopHomeScreen() {
  if (SharedPreferencesHelper.getSharedLocalData(key: isSkipOnBoardingScreen) ==
      null) {
    return OnBoardingScreen();
  } else if (SharedPreferencesHelper.getSharedLocalData(
      key: isSkipOnBoardingScreen)) {
    if (SharedPreferencesHelper.getSharedLocalData(key: TOKEN) != null) {
      return (HomeLayout());
    } else {
      return LoginScreen();
    }
  }
}
