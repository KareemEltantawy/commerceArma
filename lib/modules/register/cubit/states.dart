import 'package:ecomerce_app/models/register_model.dart';

abstract class EcommerceRegisterStates{}

class EcommerceRegisterIntialState extends EcommerceRegisterStates{}

class EcommerceRegisterLoadingState extends EcommerceRegisterStates{}

class EcommerceRegisterSuccessState extends EcommerceRegisterStates{
  final RegisterModel registerModel;

  EcommerceRegisterSuccessState(this.registerModel);
}

class EcommerceRegisterErrorState extends EcommerceRegisterStates{
   final String error;

  EcommerceRegisterErrorState(this.error);
}

class ChangePasswordVisibilityState extends EcommerceRegisterStates{}