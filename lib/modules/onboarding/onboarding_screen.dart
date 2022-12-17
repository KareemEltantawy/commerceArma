import 'package:ecomerce_app/modules/login/login_screen.dart';
import 'package:ecomerce_app/shared/components/components.dart';
import 'package:ecomerce_app/shared/network/local/cache_helper.dart';
import 'package:ecomerce_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';

class OnboardingModel {
  final String image;
  final String title;

  OnboardingModel({
    required this.image,
    required this.title,
  });
}

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<OnboardingModel> onboarding = [
    OnboardingModel(
      image: 'assets/images/1.jpg',
      title: 'Parchase Online',
    ),
    OnboardingModel(
      image: 'assets/images/2.jpg',
      title: 'Explor Many Products',
    ),
    OnboardingModel(
      image: 'assets/images/3.jpg',
      title: 'Get It Deliverd ',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (context, index) => buildItem(onboarding[index]),
        itemCount: onboarding.length,
      ),
    );
  }

  Widget buildItem(model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: AssetImage(model.image),
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  model.title,
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: defaultColor,
                    borderRadius: BorderRadius.circular(5.0)
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      CacheHelper.saveData(
                        key: 'onBoarding',
                        value: true,
                      ).then((value) {
                        if (value) {
                          navigateAndFinish(context, LoginScreen());
                        }
                      });
                    },
                    child: Text('Get Started',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                    ),),
                  ),
                ),
                SizedBox(
                  height: 60.0,
                ),
              ],
            ),
          )
        ],
      );
}
