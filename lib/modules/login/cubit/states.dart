import 'package:ecomerce_app/models/login_model.dart';

abstract class EcommerceLoginStates{}

class EcommerceLoginInitialState extends EcommerceLoginStates{}

class EcommerceLoginLoadingState extends EcommerceLoginStates{}

class EcommerceLoginSuccessState extends EcommerceLoginStates{
  final LoginModel loginModel;

  EcommerceLoginSuccessState(this.loginModel);
}

class EcommerceLoginErrorState extends EcommerceLoginStates{
  final String error;

  EcommerceLoginErrorState(this.error);
}

class ChangePasswordVisibilityState extends EcommerceLoginStates{}