import 'package:ecomerce_app/layout/cubit/cubit.dart';
import 'package:ecomerce_app/layout/cubit/states.dart';
import 'package:ecomerce_app/modules/product_details/product_details_screen.dart';
import 'package:ecomerce_app/shared/components/components.dart';
import 'package:ecomerce_app/shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EcommerceCubit, EcommerceStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return EcommerceCubit.get(context).cartModel != null
              ? EcommerceCubit.get(context).cartModel!.data!.cartItems!.length > 0 ? ListView.separated(
              itemBuilder: (context, index) => buildItem(
                  EcommerceCubit.get(context).cartModel!.data!.cartItems![index].product,
                  context),
              separatorBuilder: (context, index) => SizedBox(
                height: 10.0,
              ),
              itemCount: EcommerceCubit.get(context).cartModel!.data!.cartItems!.length) : Center(child: Text('There Is No Items',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.grey,
          ),))
              : Center(child: CircularProgressIndicator());
        });
  }
  Widget buildItem(model, context) => InkWell(
    onTap: () {
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
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
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
                            .changeCart(model.id);
                      },
                      icon: CircleAvatar(
                        radius: 22.0,
                        backgroundColor: defaultColor,
                        child: Icon(
                          Icons.delete_outline,
                          size: 19,
                          color: Colors.white,
                        ),
                      )),
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
                if (model.discount != 0)
                  Row(
                    children: [
                      Container(
                          color: Colors.grey,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            '${(((model.oldPrice - model.price) / model.oldPrice) * 100).round()}%',
                            style: TextStyle(
                              color: defaultColor,
                            ),
                          )),
                      Spacer(),
                      Text(
                        'EGP ${model.oldPrice}',
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
