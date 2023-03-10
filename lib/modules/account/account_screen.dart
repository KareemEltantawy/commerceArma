import 'package:ecomerce_app/layout/cubit/cubit.dart';
import 'package:ecomerce_app/layout/cubit/states.dart';
import 'package:ecomerce_app/modules/login/login_screen.dart';
import 'package:ecomerce_app/shared/components/components.dart';
import 'package:ecomerce_app/shared/components/constants.dart';
import 'package:ecomerce_app/shared/network/local/cache_helper.dart';
import 'package:ecomerce_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  final Uri url = Uri.parse('https://www.freeprivacypolicy.com/live/da48a0e9-25cb-4d0a-8359-a845bd1a9419');
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EcommerceCubit, EcommerceStates>(
        listener: (context, state) {},
        builder: (context, state) {

          if(EcommerceCubit.get(context).accountModel != null){
            nameController.text = EcommerceCubit.get(context).accountModel!.data!.name!;
            phoneController.text = EcommerceCubit.get(context).accountModel!.data!.phone!;
            emailController.text = EcommerceCubit.get(context).accountModel!.data!.email!;
          }

          return EcommerceCubit.get(context).accountModel != null
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          if(state is EcommerceUpdateAccountLoadingState)
                            LinearProgressIndicator(),
                          SizedBox(
                            height: 10.0,
                          ),
                          Icon(
                            Icons.account_circle,
                            size: 100.0,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                              '${EcommerceCubit.get(context).accountModel!.data!.name!}',
                          style: Theme .of(context).textTheme.bodyText2,),
                          SizedBox(
                            height: 15.0,
                          ),
                          defaultFormField(
                              controller: nameController,
                              type: TextInputType.name,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'Name Must Not Be Empty';
                                }
                                return null;
                              },
                              label: lang == 'ar' ? '??????????' :'Name',
                              prefix: Icons.person),
                          SizedBox(
                            height: 10.0,
                          ),
                          defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'Email Must Not Be Empty';
                                }
                                return null;
                              },
                              label: lang == 'ar' ? '???????????? ????????????????????' :'Email Address',
                              prefix: Icons.email_outlined),
                          SizedBox(
                            height: 10.0,
                          ),
                          defaultFormField(
                              controller: phoneController,
                              type: TextInputType.phone,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'Phone Must Not Be Empty';
                                }
                                return null;
                              },
                              label: lang == 'ar' ? '?????? ????????????' :'Phone',
                              prefix: Icons.phone_android),
                          SizedBox(
                            height: 15.0,
                          ),
                          defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  EcommerceCubit.get(context).updateAccount(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      email: emailController.text);
                                }
                              },
                              text:  lang == 'ar' ? '??????????' :'Update',
                              background: defaultColor
                          ),
                          SizedBox(height: 15.0,),
                          defaultButton(
                              function: () {
                                CacheHelper.removeData(key: 'token')
                                    .then((value) {
                                  if (value) {
                                    navigateAndFinish(context, LoginScreen());
                                  }
                                });
                              },
                              text:  lang == 'ar' ? '?????????? ????????????' :'Log Out',
                              background: defaultColor),
                          SizedBox(height: 80,),
                          TextButton(onPressed: (){
                            launchUrl(url);
                          }, child: Text('App Privacy and Policy',style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey
                          ),))
                        ],
                      ),
                    ),
                  ),
                )
              : Center(child: CircularProgressIndicator());
        });
  }
}
