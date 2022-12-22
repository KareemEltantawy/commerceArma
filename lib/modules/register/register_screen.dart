import 'package:ecomerce_app/layout/cubit/cubit.dart';
import 'package:ecomerce_app/layout/layout.dart';
import 'package:ecomerce_app/modules/login/login_screen.dart';
import 'package:ecomerce_app/modules/register/cubit/cubit.dart';
import 'package:ecomerce_app/modules/register/cubit/states.dart';
import 'package:ecomerce_app/shared/components/components.dart';
import 'package:ecomerce_app/shared/components/constants.dart';
import 'package:ecomerce_app/shared/network/local/cache_helper.dart';
import 'package:ecomerce_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => EcommerceRegisterCubit(),
      child: BlocConsumer<EcommerceRegisterCubit, EcommerceRegisterStates>(
        listener: (context, state) {
          if (state is EcommerceRegisterSuccessState) {
            if (state.registerModel.status!) {
              CacheHelper.saveData(
                      key: 'token', value: state.registerModel.data!.token)
                  .then((value) {
                token = state.registerModel.data!.token;
                navigateAndFinish(context, Layout());
              });
            } else {
              showToast(
                  msg: state.registerModel.message!,
                  backgroundColor: Colors.red);
            }
          }
        },
        builder: (context, state) {
          return Directionality(
            textDirection: lang == 'ar' ? TextDirection.rtl : TextDirection.ltr,
            child: Scaffold(
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
                            lang == 'ar' ? 'انشاء حساب' :'Creat Account',
                            style: Theme.of(context).textTheme.bodyText1,
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
                                  EcommerceRegisterCubit.get(context).isPassword,
                              suffixPressed: () {
                                EcommerceRegisterCubit.get(context)
                                    .changePassword();
                              },
                              suffix:
                                  EcommerceRegisterCubit.get(context).isPassword
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
                            height: 15.0,
                          ),
                          defaultFormField(
                              controller: nameController,
                              type: TextInputType.name,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'name must not be empty';
                                }
                                return null;
                              },
                              label: lang == 'ar' ? 'الاسم' :'Name',
                              prefix: Icons.person),
                          SizedBox(
                            height: 15.0,
                          ),
                          defaultFormField(
                              controller: phoneController,
                              type: TextInputType.phone,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'phone must not be empty';
                                }
                                return null;
                              },
                              label: lang == 'ar' ? 'رقم الهاتف' :'Phone',
                              prefix: Icons.phone_android),
                          SizedBox(
                            height: 35.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              state is! EcommerceRegisterLoadingState
                                  ? InkWell(
                                      onTap: () {
                                        if(formKey.currentState!.validate()){
                                          EcommerceRegisterCubit.get(context)
                                              .userRegister(
                                              email: emailController.text,
                                              password: passwordController.text,
                                              name: nameController.text,
                                              phone: phoneController.text);
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20.0,
                                          vertical: 12.0,
                                        ),
                                        decoration: BoxDecoration(
                                            color: defaultColor,
                                            borderRadius: BorderRadius.circular(30.0)),
                                        child: Row(
                                          children: [
                                            Text(
                                              lang == 'ar' ? 'تسجيل' :'Register',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Icon(
                                              lang == 'ar' ? Icons.keyboard_arrow_left_rounded :Icons.arrow_right_alt,
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

                        ],
                      ),
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
