import 'package:first_app/model/on_boarding/on_boarding.dart';
import 'package:first_app/modules/shop_app/login/login_screen.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/components/constants.dart';
import 'package:first_app/shared/network/local/shared_helper.dart';
import 'package:first_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoarding> onBoardingList = [
    OnBoarding("assets/images/onboard_1.jpg", "Lorem ipsum",
        "consectetur adipiscing elit. Donec consequat, risus nec convallis mattis"),
    OnBoarding("assets/images/onboard_1.jpg", "Lorem ipsum",
        " Donec consequat, risus nec convallis mattis,consectetur adipiscing elit."),
    OnBoarding("assets/images/onboard_1.jpg", "Lorem ipsum",
        "risus nec convallis mattis,consectetur adipiscing elit. Donec consequat"),
  ];

  PageController pageController = PageController();

  bool isLastItem = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            defaultTextButton(
              function: navToLoginScreen,
              text: 'skip',
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (int value) {
                    if (value == onBoardingList.length - 1) {
                      isLastItem = true;
                      setState(() {});
                    } else {
                      isLastItem = false;
                      setState(() {});
                    }
                  },
                  controller: pageController,
                  itemBuilder: (context, index) {
                    return buildPageViewItem(context, onBoardingList[index]);
                  },
                  itemCount: onBoardingList.length,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                      controller: pageController,
                      count: onBoardingList.length,
                      effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: primaryColor,
                        dotHeight: 10,
                        expansionFactor: 4,
                        dotWidth: 10,
                        spacing: 5.0,
                      )),
                  Spacer(),
                  FloatingActionButton(
                    child: Icon(Icons.arrow_forward_rounded),
                    onPressed: () {
                      if (isLastItem) {
                        navToLoginScreen();
                      } else {
                        pageController.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget buildPageViewItem(context, OnBoarding onBoardingData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Image(image: AssetImage(onBoardingData.imageUrl))),
        Text(
          onBoardingData.title,
          style: Theme.of(context).textTheme.headline4,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          onBoardingData.body,
          style: Theme.of(context).textTheme.bodyText1,
        )
      ],
    );
  }

  void navToLoginScreen() {
    SharedPreferencesHelper.putSharedLocalData(
        key: isSkipOnBoardingScreen, value: true);
    navigateAndRemove(context: context, widget: LoginScreen());
  }
}
