import 'package:ecomerce_app/layout/cubit/cubit.dart';
import 'package:ecomerce_app/layout/layout.dart';
import 'package:ecomerce_app/modules/login/cubit/cubit.dart';
import 'package:ecomerce_app/modules/register/register_screen.dart';
import 'package:ecomerce_app/shared/components/components.dart';
import 'package:ecomerce_app/shared/components/constants.dart';
import 'package:ecomerce_app/shared/network/local/cache_helper.dart';
import 'package:ecomerce_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => EcommerceLoginCubit(),
      child: BlocConsumer<EcommerceLoginCubit, EcommerceLoginStates>(
        listener: (context, state) {
          if (state is EcommerceLoginSuccessState) {
            if (state.loginModel.status!) {
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token;
                EcommerceCubit.get(context).getHome();
                EcommerceCubit.get(context).getCategories();
                EcommerceCubit.get(context).getFavorites();
                EcommerceCubit.get(context).getAccount();
                navigateAndFinish(context, Layout());
              });
            } else {
              showToast(
                  msg: state.loginModel.message!, backgroundColor: Colors.red);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lang == 'ar' ? 'تسجيل الدخول' :'Login',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          lang == 'ar' ? 'قم بتسجيل الدخول للاستكمال' :'Please log In To Continue',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'email must not be empty';
                              }
                              return null;
                            },
                            label: lang == 'ar' ? 'البريد الالكتروني' :'Email Address',
                            prefix: Icons.email_outlined),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            controller: passwordController,
                            isPassword:
                                EcommerceLoginCubit.get(context).isPassword,
                            suffixPressed: () {
                              EcommerceLoginCubit.get(context).changePassword();
                            },
                            suffix: EcommerceLoginCubit.get(context).isPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            type: TextInputType.visiblePassword,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'password must not be empty';
                              }
                              return null;
                            },
                            label: lang == 'ar' ? 'كلمه المرور' :'Password',
                            prefix: Icons.lock),
                        SizedBox(
                          height: 35.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            state is! EcommerceLoginLoadingState
                                ? InkWell(
                                    onTap: () {
                                      if(formKey.currentState!.validate()){
                                        EcommerceLoginCubit.get(context)
                                            .userLogin(
                                            email: emailController.text,
                                            password:
                                            passwordController.text);
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20.0,
                                        vertical: 12.0,
                                      ),
                                      decoration: BoxDecoration(
                                          color: defaultColor,
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      child: Row(
                                        children: [
                                          Text(
                                            lang == 'ar' ? 'تسجيل الدخول' :'Login',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Icon(
                                            lang == 'ar' ? Icons.keyboard_arrow_left_rounded : Icons.arrow_right_alt,
                                            size: 23.0,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : CircularProgressIndicator(),
                          ],
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              lang == 'ar' ? 'لا تمتلك حساب ؟' :'Dont\' have account',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, RegisterScreen());
                                }, child: Text(lang == 'ar' ? 'تسجيل حساب' :'Register'))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
