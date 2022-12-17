import 'package:ecomerce_app/layout/cubit/cubit.dart';
import 'package:ecomerce_app/layout/cubit/states.dart';
import 'package:ecomerce_app/modules/product_details/product_details_screen.dart';
import 'package:ecomerce_app/shared/components/components.dart';
import 'package:ecomerce_app/shared/components/constants.dart';
import 'package:ecomerce_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EcommerceCubit, EcommerceStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: searchController,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          EcommerceCubit.get(context).search(value);
                        },
                        decoration: InputDecoration(
                          hintText: lang == 'ar' ? 'عن ماذا تبحث ؟' :'What are you looking for ?',
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(lang == 'ar' ? 'اغلاق':'Cancel',
                        style: TextStyle(
                          color: defaultColor,
                        ),
                      ))
                ],
              ),
            ),
            body: EcommerceCubit.get(context).searchModel != null
                ? ListView.separated(
                    itemBuilder: (context, index) => buildItem(
                        EcommerceCubit.get(context)
                            .searchModel!
                            .data!
                            .data![index],
                        context),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10.0,
                        ),
                    itemCount: EcommerceCubit.get(context)
                        .searchModel!
                        .data!
                        .data!
                        .length)
                : Container(),
          );
        });
  }

  Widget buildItem(model, context) => InkWell(
        onTap: () {
          EcommerceCubit.get(context).getProductDetails(model.id);
          navigateTo(context, ProductDetailsScreen());
        },
        child: Card(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  fit: BoxFit.cover,
                  height: 200.0,
                  width: double.infinity,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  model.name,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Text(
                      '${model.price}',
                      style: TextStyle(color: defaultColor, fontSize: 16.0),
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          EcommerceCubit.get(context).changeFavorites(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 22.0,
                          backgroundColor:
                              EcommerceCubit.get(context).favorites[model.id]!
                                  ? defaultColor
                                  : Colors.grey,
                          child: Icon(
                            Icons.favorite_outline,
                            size: 18.0,
                            color: Colors.white,
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      );
}
