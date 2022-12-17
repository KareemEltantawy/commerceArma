import 'package:ecomerce_app/models/register_model.dart';
import 'package:ecomerce_app/modules/register/cubit/states.dart';
import 'package:ecomerce_app/shared/network/end_points.dart';
import 'package:ecomerce_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EcommerceRegisterCubit extends Cubit<EcommerceRegisterStates>{

  EcommerceRegisterCubit():super(EcommerceRegisterIntialState());
  static EcommerceRegisterCubit get(context) => BlocProvider.of(context);

  RegisterModel? registerModel;

  void userRegister({
  required String email,
    required String password,
    required String name,
    required String phone,
}){
    emit(EcommerceRegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'email':email,
      'password':password,
      'name':name,
      'phone':phone,
    }).then((value) {
      registerModel = RegisterModel.fromJson(value.data);
      emit(EcommerceRegisterSuccessState(registerModel!));
    }).catchError((error){
      print(error.toString());
      emit(EcommerceRegisterErrorState(error.toString()));
    });
  }

  bool isPassword = true;
  void changePassword(){
    isPassword = !isPassword;
    emit(ChangePasswordVisibilityState());
  }
}