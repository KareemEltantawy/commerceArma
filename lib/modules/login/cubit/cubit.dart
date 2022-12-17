import 'package:ecomerce_app/models/login_model.dart';
import 'package:ecomerce_app/modules/login/cubit/states.dart';
import 'package:ecomerce_app/shared/network/end_points.dart';
import 'package:ecomerce_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EcommerceLoginCubit extends Cubit<EcommerceLoginStates>{

  EcommerceLoginCubit():super(EcommerceLoginInitialState());
  static EcommerceLoginCubit get(context) =>BlocProvider.of(context);

  LoginModel? loginModel;

  void userLogin({
  required String email,
    required String password,
}){
    emit(EcommerceLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data:{
          "email": email,
          "password" : password,
        }
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(EcommerceLoginSuccessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(EcommerceLoginErrorState(error.toString()));
    });
  }

  bool isPassword = true;
  void changePassword(){
    isPassword = !isPassword;
    emit(ChangePasswordVisibilityState());
  }


}