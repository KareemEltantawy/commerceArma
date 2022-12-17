import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecomerce_app/layout/cubit/cubit.dart';
import 'package:ecomerce_app/layout/cubit/states.dart';
import 'package:ecomerce_app/shared/components/constants.dart';
import 'package:ecomerce_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EcommerceCubit, EcommerceStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(lang == 'ar' ? 'تفاصيل المنتج' :'Product Details'),
            ),
            body: EcommerceCubit.get(context).productDetailsModel != null
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomStart,
                          children: [
                            CarouselSlider(
                                items: EcommerceCubit.get(context)
                                    .productDetailsModel!
                                    .data!
                                    .images!
                                    .map((e) => Image(
                                          image: NetworkImage(e),
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ))
                                    .toList(),
                                options: CarouselOptions(
                                  height: 300.0,
                                  viewportFraction: 1.0,
                                  autoPlay: true,
                                )),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (EcommerceCubit.get(context)
                                        .productDetailsModel!
                                        .data!
                                        .discount !=
                                    0)
                                  Container(
                                    color: Colors.red,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text(
                                      'Discount',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                Spacer(),
                                IconButton(
                                    onPressed: () {
                                      EcommerceCubit.get(context)
                                          .changeFavorites(
                                              EcommerceCubit.get(context)
                                                  .productDetailsModel!
                                                  .data!
                                                  .id!);
                                    },
                                    icon: CircleAvatar(
                                      radius: 22.0,
                                      backgroundColor:
                                          EcommerceCubit.get(context).favorites[
                                                  EcommerceCubit.get(context)
                                                      .productDetailsModel!
                                                      .data!
                                                      .id]!
                                              ? defaultColor
                                              : Colors.grey,
                                      child: Icon(
                                        Icons.favorite_outline,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ))
                              ],
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                EcommerceCubit.get(context)
                                    .productDetailsModel!
                                    .data!
                                    .name!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${EcommerceCubit.get(context).productDetailsModel!.data!.price} EGP',
                                    style: TextStyle(
                                        fontSize: 14.0, color: defaultColor),
                                  ),
                                  SizedBox(
                                    width: 15.0,
                                  ),
                                  if (EcommerceCubit.get(context)
                                          .productDetailsModel!
                                          .data!
                                          .discount !=
                                      0)
                                    Text(
                                      '${EcommerceCubit.get(context).productDetailsModel!.data!.oldPrice} EGP',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.grey,
                                          decoration:
                                          TextDecoration.lineThrough),
                                    ),
                                ],
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Text(
                                lang == 'ar' ? 'التفاصيل' :'Details',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                '${EcommerceCubit.get(context).productDetailsModel!.data!.description!}',
                                style: Theme.of(context).textTheme.bodyText2,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                : Center(child: CircularProgressIndicator()),
          );
        });
  }
}
