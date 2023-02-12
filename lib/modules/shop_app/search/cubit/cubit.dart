import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/models/shop_app/search_model.dart';
import 'package:udemy_flutter/modules/shop_app/search/cubit/states.dart';
import 'package:udemy_flutter/shared/components/constants.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';
import 'package:udemy_flutter/shared/network/remote/end_points.dart';

class ShopSearchCubit extends Cubit<ShopSearchStates>{
  ShopSearchCubit() : super(ShopSearchInitialState());

  static ShopSearchCubit get(BuildContext context) => BlocProvider.of(context);

  SearchModel ? searchModel;

  void search({
    required String text,
}){
    emit(ShopSearchLoadingState());
    DioHelper.postData(
      url: PRODUCTS_SEARCH,
      token: token,
      data: {
        'text' : text,
      }
    ).then((value){

      searchModel = SearchModel.fromJson(value.data);
      emit(ShopSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopSearchErrorState());
    });
  }
}