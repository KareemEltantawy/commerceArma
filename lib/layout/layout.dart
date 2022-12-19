import 'package:ecomerce_app/modules/search/search_screen.dart';
import 'package:ecomerce_app/shared/components/components.dart';
import 'package:ecomerce_app/shared/components/constants.dart';
import 'package:ecomerce_app/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class Layout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EcommerceCubit, EcommerceStates>(
      listener: (context, state) {},
      builder: (context, state) {

        var cubit = EcommerceCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(lang == 'ar' ? 'كمرس ارما' :'CommerceArma'),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  navigateTo(context,SearchScreen());
                },
              ),
              IconButton(
                icon: Icon(Icons.brightness_4_outlined),
                onPressed: () {
                  AppCubit.get(context).changeAppMode();
                  },
              ),
              IconButton(
                icon: Icon(Icons.language),
                onPressed: () {
                  AppCubit.get(context).changeLanguage();
                  cubit.getHome();
                  cubit.getFavorites();
                  cubit.getCategories();
                  cubit.getAccount();
                  cubit.getCarts();
                },
              ),

            ],
          ),
          body: cubit.Screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: lang == 'ar' ? 'الرئيسيه' :'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.trending_up,
                ),
                label: lang == 'ar' ? 'شائع' :'Trends',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                ),
                label: lang == 'ar' ? 'المفضله' :'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_shopping_cart_outlined,
                ),
                label: lang == 'ar' ? 'العربه' :'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle_outlined,
                ),
                label: lang == 'ar' ? 'حسابي' :'My Account',
              ),
            ],
          ),
        );
      },
    );
  }
}
