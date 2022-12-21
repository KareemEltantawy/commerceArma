import 'package:ecomerce_app/layout/cubit/cubit.dart';
import 'package:ecomerce_app/layout/cubit/states.dart';
import 'package:ecomerce_app/modules/product_details/product_details_screen.dart';
import 'package:ecomerce_app/shared/components/components.dart';
import 'package:ecomerce_app/shared/components/constants.dart';
import 'package:ecomerce_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EcommerceCubit, EcommerceStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Directionality(
            textDirection: lang == 'ar' ? TextDirection.rtl : TextDirection.ltr,
            child: Scaffold(
              appBar: AppBar(),
              body: EcommerceCubit.get(context).categoryProductsModel != null ? GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0,
                childAspectRatio: MediaQuery.of(context).size.width / 680,
                children: List.generate(EcommerceCubit.get(context).categoryProductsModel!.data!.data!.length,
                        (index) => buildItem(EcommerceCubit.get(context).categoryProductsModel!.data!.data![index], context)),
              ) : Center(child: CircularProgressIndicator()),
            ),
          );
        });
  }

  Widget buildItem(model, context) => InkWell(
    onTap: (){
      EcommerceCubit.get(context).getProductDetails(model.id);
      navigateTo(context, ProductDetailsScreen());
    },
    child: Card(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Image(
                image: NetworkImage(model.image),
                fit: BoxFit.cover,
                height: 200.0,
                width: double.infinity,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (model.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 2.0),
                      child: Text(
                        'Discount',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                        ),
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
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'EGP ${model.price}',
                  style: TextStyle(fontSize: 14.0, color: defaultColor),
                ),
                SizedBox(
                  height: 10.0,
                ),
                if(model.discount!=0)
                  Row(
                    children: [
                      Container(
                          color: Colors.grey,
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text('${(((model.oldPrice-model.price) / model.oldPrice)*100).round()}%',
                            style: TextStyle(
                              color: defaultColor,
                            ),
                          )),
                      Spacer(),
                      Text('EGP ${model.oldPrice.round()}',
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  ),
              ],
            ),
          )
        ],
      ),
    ),
  );


}
