import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/shop_app/cubit/states.dart';
import 'package:udemy_flutter/models/shop_app/categories_model.dart';
import 'package:udemy_flutter/models/shop_app/change_favorite_model.dart';
import 'package:udemy_flutter/models/shop_app/favorite_model.dart';
import 'package:udemy_flutter/models/shop_app/home_model.dart';
import 'package:udemy_flutter/models/shop_app/login_model.dart';
import 'package:udemy_flutter/modules/shop_app/categories/categories_screen.dart';
import 'package:udemy_flutter/modules/shop_app/favorite/favorite_screen.dart';
import 'package:udemy_flutter/modules/shop_app/products/products_screen.dart';
import 'package:udemy_flutter/modules/shop_app/settings/settings_screen.dart';
import 'package:udemy_flutter/shared/components/constants.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

import '../../../shared/network/remote/end_points.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(ShopInitiateState());

  static ShopCubit get(BuildContext context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingsScreen(),
  ];

  HomeModel ? homeModel;
  CategoryModel ? categoryModel;
  Map<int? , bool?> favorite = {};
  ChangeFavoriteModel ? changeFavoriteModel;
  FavoriteModel ? favoriteModel;

  void changeBottomIndex(int index){
    currentIndex = index;
    emit(ShopChangeBottomNavigationBarState());
  }

  void getHomeData(){
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      path: HOME,
    ).then((value){
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data!.productList.forEach((element){
        favorite.addAll({
          element.id : element.inFavorites
        });
      });
      // print('Fav :    ${favorite.toString()}');
      emit(ShopSuccessHomeDataState());
    }).catchError((error){
      print('Error : ${error.toString()}');
      emit(ShopErrorHomeDataState(error: error.toString()));
    });
  }


  void getCategoryData(){
    DioHelper.getData(
      path: GET_CATEGORIES ,
      token: token,
    ).then((value){
      categoryModel = CategoryModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesState(error: error));
    });
  }

  void changeFavorites(int productId){

    favorite[productId] = !favorite[productId]!;
    emit(ShopSuccessFavoriteState());

    DioHelper.postData(
      url: FAVORITE,
      token: token,
      data: {
        'product_id' : productId
      },
    ).then((value){
      print(token);
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
      print(value.data);
      emit(ShopSuccessChangeFavoriteState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorChangeFavoriteState(error: error));
    });
  }

  void getFavorites(){

    DioHelper.getData(
      path: FAVORITE,
      token: token,
    ).then((value){
      favoriteModel = FavoriteModel.fromJson(value.data);
      // printFullText(text: '####################  ${value.data.toString()}');

      emit(ShopSuccessGetFavoriteState());
    }).catchError((error){
      print(error);
      emit(ShopErrorGetFavoriteState());
    });
  }

  ShopLoginModel ? userModel;

  void getUserData(){
    DioHelper.getData(
      path: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      printFullText(text: userModel!.data!.name.toString());
      emit(ShopSuccessGetUserDataState(userModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String phone,
    required String email,
}){
    emit(ShopLoadingUpdateUserDataState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'phone': phone,
        'email': email,
      },
    ).then((value) {

      userModel = ShopLoginModel.fromJson(value.data);
      printFullText(text: userModel!.data!.name.toString());
      emit(ShopSuccessUpdateUserDataState(userModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUpdateUserDataState());
    });
  }

}