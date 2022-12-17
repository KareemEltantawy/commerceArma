import 'package:ecomerce_app/models/account_model.dart';
import 'package:ecomerce_app/models/categories_model.dart';
import 'package:ecomerce_app/models/category_products_model.dart';
import 'package:ecomerce_app/models/chane_favorites_model.dart';
import 'package:ecomerce_app/models/favorites_model.dart';
import 'package:ecomerce_app/models/home_model.dart';
import 'package:ecomerce_app/models/product_details_model.dart';
import 'package:ecomerce_app/models/search_model.dart';
import 'package:ecomerce_app/models/update_account_model.dart';
import 'package:ecomerce_app/modules/account/account_screen.dart';
import 'package:ecomerce_app/modules/trends/trends_screen.dart';
import 'package:ecomerce_app/shared/components/constants.dart';
import 'package:ecomerce_app/shared/network/end_points.dart';
import 'package:ecomerce_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/../modules/favorites/favorites_screen.dart';
import '/../modules/home/home_screen.dart';
import 'states.dart';

class EcommerceCubit extends Cubit<EcommerceStates> {
  EcommerceCubit() : super(EcommerceInitialState());

  static EcommerceCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> Screens = [
    HomeScreen(),
    TrendsScreen(),
    FavoritesScreen(),
    AccountScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(EcommerceChangeBottomNavState());
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(url: CATEGORIES).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(EcommerceCategoriesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(EcommerceCategoriesErrorState());
    });
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  void getHome() {
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products!.forEach((element) {
        favorites.addAll({element.id!: element.inFavorites!});
      });
      emit(EcommerceCategoriesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(EcommerceHomeErrorState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(EcommerceFavoritesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(EcommerceFavoritesErrorState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(EcommerceChangeFavoritesState());
    DioHelper.postData(
            url: FAVORITES, data: {'product_id': productId}, token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (!changeFavoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }
      emit(EcommerceChangeFavoritesSuccessState());
    }).catchError((error) {
      print(error.toString());
      favorites[productId] = !favorites[productId]!;
      emit(EcommerceChangeFavoritesErrorState());
    });
  }

  CategoryProductsModel? categoryProductsModel;

  void getCategoreProducts(int categoryId) {
    categoryProductsModel = null;
    DioHelper.getData(
            url: PRODUCTS, query: {'category_id': categoryId}, token: token)
        .then((value) {
      categoryProductsModel = CategoryProductsModel.fromJson(value.data);
      categoryProductsModel!.data!.data!.forEach((element) {
        if (!favorites.containsKey(element.id!)) {
          favorites.addAll({element.id!: element.inFavorites!});
        }
      });
      emit(EcommerceCategoryProductsErrorState());
    }).catchError((error) {
      print(error.toString());
      emit(EcommerceCategoryProductsErrorState());
    });
  }

  SearchModel? searchModel;

  void search(String text) {
    DioHelper.postData(
      url: SEARCH,
      data: {
        'text': text,
      },
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      searchModel!.data!.data!.forEach((element) {
        if (!favorites.containsKey(element.id!)) {
          favorites.addAll({element.id!: element.inFavorites!});
        }
      });
      emit(EcommerceSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(EcommerceSearchErrorState());
    });
  }

  ProductDetailsModel? productDetailsModel;

  void getProductDetails(int productId) {
    productDetailsModel = null;
    DioHelper.getData(url: 'products/$productId', token: token).then((value) {
      productDetailsModel = ProductDetailsModel.fromJson(value.data);
      emit(EcommerceProductDetailsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(EcommerceProductDetailsErrorState());
    });
  }

  AccountModel? accountModel;

  void getAccount() {
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      accountModel = AccountModel.fromJson(value.data);
      emit(EcommerceAccountSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(EcommerceAccountErrorState());
    });
  }

  UpdateAccountModel? updateAccountModel;

  void updateAccount({
    required String name,
    required String phone,
    required String email,
  }) {
    emit(EcommerceUpdateAccountLoadingState());
    DioHelper.putData(url: UPDATE_PROFILE, data: {
      'name': name,
      'phone': phone,
      'email': email,
    },
    token: token,
    ).then((value) {
      updateAccountModel = UpdateAccountModel.fromJson(value.data);
      if(updateAccountModel!.status!){
        getAccount();
      }
      emit(EcommerceUpdateAccountSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(EcommerceUpdateAccountErrorState());
    });
  }
}
