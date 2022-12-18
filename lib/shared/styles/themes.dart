import 'package:ecomerce_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightTheme = ThemeData(
  appBarTheme: AppBarTheme(
    backwardsCompatibility: false,  //false alashan aref aAdel fe el status bar
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white, // the same color as backgroundColor of the appbar
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      fontFamily: 'Jannah',
      color: Colors.red,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
 scaffoldBackgroundColor: Colors.white,
primarySwatch: defaultColor,
textTheme: TextTheme(
  bodyText1: TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
    bodyText2: TextStyle(
      fontSize: 15.0,
      height: 1.3,
      color: Colors.black,
    )
),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor:defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: Colors.white,
  ),
fontFamily: 'Jannah',
);



ThemeData darkTheme = ThemeData(
  appBarTheme: AppBarTheme(
    backwardsCompatibility: false,  //false alashan aref aAdel fe el status bar
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'), // the same color as backgroundColor of the appbar
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: HexColor('333739'),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      fontFamily: 'Jannah',
      color: Colors.red,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  scaffoldBackgroundColor: HexColor('333739'),
  primarySwatch: defaultColor,
  textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyText2: TextStyle(
        fontSize: 15.0,
        height: 1.3,
        color: Colors.white,
      )
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor:defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: HexColor('333739'),
  ),
  fontFamily: 'Jannah',
);