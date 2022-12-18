import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecomerce_app/layout/cubit/cubit.dart';
import 'package:ecomerce_app/layout/cubit/states.dart';
import 'package:ecomerce_app/modules/category_products/category_products_screen.dart';
import 'package:ecomerce_app/modules/product_details/product_details_screen.dart';
import 'package:ecomerce_app/shared/components/components.dart';
import 'package:ecomerce_app/shared/components/constants.dart';
import 'package:ecomerce_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EcommerceCubit, EcommerceStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return (EcommerceCubit.get(context).homeModel != null &&
                EcommerceCubit.get(context).categoriesModel != null)
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text(
                        lang == 'ar' ? 'الفئات' :'Categories',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Container(
                      height: 130.0,
                      padding: EdgeInsets.symmetric(horizontal: 14.0),
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => buildCategoryItem(
                            EcommerceCubit.get(context)
                                .categoriesModel!
                                .data!
                                .data![index],
                            context),
                        separatorBuilder: (context, index) => SizedBox(
                          width: 15.0,
                        ),
                        itemCount: EcommerceCubit.get(context)
                            .categoriesModel!
                            .data!
                            .data!
                            .length,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text(
                        lang == 'ar' ? 'العروض' :'Offers',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    CarouselSlider(
                      items: EcommerceCubit.get(context)
                          .homeModel!
                          .data!
                          .banners!
                          .map((e) => Image(
                                image: NetworkImage(e.image!),
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ))
                          .toList(),
                      options: CarouselOptions(
                        height: 200.0,
                        viewportFraction: 1.0,
                        autoPlay: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text(
                        lang == 'ar' ? 'المحتوي الرائج' :'People Most Buy',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => buildProductItem(
                            EcommerceCubit.get(context)
                                .homeModel!
                                .data!
                                .products![index+6],
                            context),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 8.0,
                            ),
                        itemCount: EcommerceCubit.get(context)
                            .homeModel!
                            .data!
                            .products!
                            .length-6)
                  ],
                ),
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildCategoryItem(model, context) => InkWell(
        onTap: () {
          EcommerceCubit.get(context).getCategoreProducts(model.id);
          navigateTo(context, CategoryProductsScreen());

        },
        child: Container(
          width: 90.0,
          child: Column(
            children: [
              CircleAvatar(
                radius: 45.0,
                backgroundImage: NetworkImage(model.image),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                model.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText2,
              )
            ],
          ),
        ),
      );

  Widget buildProductItem(model, context) => InkWell(
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
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image(
                      image: NetworkImage(model.image),
                      fit: BoxFit.cover,
                      height: 200.0,
                      width: double.infinity,
                    ),
                    if (model.discount != 0)
                      Container(
                        color: Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Discount',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                        ),
                      )
                  ],
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
                      'EGP ${model.price}',
                      style: TextStyle(color: defaultColor, fontSize: 16.0),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    if (model.discount != 0)
                      Text(
                        'EGP ${model.oldPrice}',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          EcommerceCubit.get(context)
                              .changeCart(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 22.0,
                          backgroundColor: EcommerceCubit.get(context).carts[model.id]! ? defaultColor : Colors.grey,
                          child: Icon(
                            Icons.add_shopping_cart_outlined,
                            size: 16,
                            color: Colors.white,
                          ),
                        )),
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
