// https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca
// base url: https://newsapi.org/
// method : v2/everything?
// query : q=apple&from=2022-10-26&to=2022-10-26&sortBy=popularity&apiKey=60e04c04e8b14b41b6a9236646e72d71


// https://newsapi.org/v2/everything?q=tesla&apiKey=60e04c04e8b14b41b6a9236646e72d71

import 'package:flutter/material.dart';

import '../../modules/shop_app/login/shop_login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

void signOut(BuildContext context){
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(
          context: context,
          widget: ShopLoginScreen()
      );
    }
  });
}


//To print full text:

void printFullText({required String text}){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match){
    print(match.group(0));
  });
}

String ? token ;
String ? uId ;