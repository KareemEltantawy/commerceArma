import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';

import 'package:ecomerce_app/layout/layout.dart';
import 'package:ecomerce_app/modules/login/login_screen.dart';
import 'package:ecomerce_app/shared/components/constants.dart';
import 'package:ecomerce_app/shared/cubit/cubit.dart';
import 'package:ecomerce_app/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/cubit/cubit.dart';
import 'modules/onboarding/onboarding_screen.dart';
import 'shared/bloc_observer.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/network/remote/dio_helper.dart';
import 'shared/styles/themes.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ByteData data = await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');//to solve error when run on  my phone
  SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());//to solve error when run on  my phone
  await CacheHelper.init(); //lAn ba await ala CacheHelper.init() lazem el main ybka async we lAn el main bka async lazwm adef el method...> WidgetsFlutterBinding.ensureInitialized()
  DioHelper.init();
  Bloc.observer = MyBlocObserver();

  bool? isDark = CacheHelper.getData(key: 'isDark'); // we use the same key we use in saveData method
  String? languageFromShared = CacheHelper.getData(key: 'lang');
  token = CacheHelper.getData(key: 'token');
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  Widget startWidget;

  if (onBoarding != null) {
    if (token != null) {
      startWidget = Layout();
    } else {
      startWidget = LoginScreen();
    }
  } else {
    startWidget = OnboardingScreen();
  }

  runApp(MyApp(
    languageFromShared: languageFromShared,
    isDark: isDark,
    startWidget: startWidget,
  ));
}

class MyApp extends StatelessWidget {
  bool? isDark;
  final Widget startWidget;
  String? languageFromShared;

  MyApp({
    this.isDark,
    required this.startWidget,
    this.languageFromShared
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => AppCubit()..changeAppMode(isDarkFromShared: isDark)..changeLanguage(languageFromShared: languageFromShared)
        ),
        BlocProvider(
            create: (BuildContext context) => EcommerceCubit()..getHome()..getFavorites()..getCategories()..getAccount()..getCarts()
        ),

      ],
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              home: startWidget,
            );
          }),
    );
  }
}
