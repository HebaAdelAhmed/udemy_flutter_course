import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/models/shop_app/login_model.dart';
import 'package:udemy_flutter/modules/shop_app/login/cubit/states.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

import '../../../../shared/network/remote/end_points.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{

  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel ? shopLoginModel;
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility(){

    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibility());
  }

  void userLogin({required String email ,
    required String password
  }){
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN ,
      data:
      {
       'email' : email,
       'password' : password,
      }
      ).then((value) {
        print(value.data);
        shopLoginModel = ShopLoginModel.fromJson(value.data);
        print(shopLoginModel?.message);
        print(shopLoginModel?.status);
        print(shopLoginModel?.data?.token);
        emit(ShopLoginSuccessState(shopLoginModel: shopLoginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState(error: error.toString()));
    });
  }
}