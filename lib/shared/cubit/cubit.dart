

import 'package:ecomerce_app/shared/components/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/./shared/network/local/cache_helper.dart';
import 'states.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = true;

  void changeAppMode({bool? isDarkFromShared})
  {
    if (isDarkFromShared != null)    //when we call changeAppMode() from the main
    {
      isDark = isDarkFromShared;
      emit(AppChangeModeState());
    } else    //when we call changeAppMode() from the button
      {
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark).then((value)
      {
        emit(AppChangeModeState());
      });
    }
  }


   void changeLanguage({String? languageFromShared}){
     if(languageFromShared!=null){
       lang = languageFromShared;
       emit(AppChangeLangState());
     }else{
       if(lang == 'en'){
         lang = 'ar';
       }else{
         lang = 'en';
       }
       CacheHelper.saveData(key: 'lang', value: lang).then((value){
         emit(AppChangeLangState());
       });
     }
   }


}
