import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/news_app/cubit/states.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';
import '../../../modules/news_app/business/business_screen.dart';
import '../../../modules/news_app/science/science_screen.dart';
import '../../../modules/news_app/sport/sport_screen.dart';
import '../../../shared/network/remote/dio_helper.dart';

class NewsAppCubit extends Cubit<NewsAppStates>{

  NewsAppCubit() : super(NewsAppInitialState());

  static NewsAppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  ThemeMode appMode = ThemeMode.dark;
  bool isDark = false;

  void changeThemeMode({bool ? fromShared}){
    if(fromShared != null){
      isDark = fromShared;
      emit(ChangeAppMode());
    }
    else{
      isDark = !isDark;
      CacheHelper.putDate(key: 'isDark' , value: isDark).then((value){
        emit(ChangeAppMode());
      });
    }

  }

  List<Widget> screens = [
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),
  ];

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business'
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports
      ),
      label: 'Sport'
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science
      ),
      label: 'Science'
    ),
  ];

  void changeCurrentIndex(int index){
    currentIndex = index;
    if(index == 1){
      getSportsData();
    }else if(index == 2){
      getScienceData();
    }
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];

  void getBusinessData() async {
    emit(NewsGetBusinessLoadingState());
    if(business.length == 0){
      DioHelper.getData(
          path: 'v2/top-headlines' ,
          queryParameters: {
            'country': 'eg',
            'category': 'business' ,
            'apiKey' : '65f7f556ec76449fa7dc7c0069f040ca',
          }
      ).then((value){
        business = value.data['articles'];
        print(business.length);
        emit(NewsGetBusinessDataSuccessfullyState());
      }).catchError((error){
        print('############# ERROR ############ ${error.toString()}');
        emit(NewsGetBusinessDataErrorState(error: error.toString()));
      });
    }else{
      emit(NewsGetBusinessDataSuccessfullyState());
    }
  }

  void getSportsData() async {
    emit(NewsGetSportDataLoadingState());
    if(sports.length == 0){
      DioHelper.getData(
          path: 'v2/top-headlines' ,
          queryParameters: {
            'country': 'eg',
            'category': 'sports' ,
            'apiKey' : '65f7f556ec76449fa7dc7c0069f040ca',
          }
      ).then((value){
        sports = value.data['articles'];
        print(sports.length);
        emit(NewsGetSportDataSuccessfullyState());
      }).catchError((error){
        print('############# ERROR ############ ${error.toString()}');
        emit(NewsGetSportDataErrorState(error: error.toString()));
      });
    }else{
      emit(NewsGetSportDataSuccessfullyState());
    }
  }

  void getScienceData() async {
    emit(NewsGetScienceDataLoadingState());
    if(science.length == 0){
      DioHelper.getData(
          path: 'v2/top-headlines' ,
          queryParameters: {
            'country': 'eg',
            'category': 'science' ,
            'apiKey' : '65f7f556ec76449fa7dc7c0069f040ca',
          }
      ).then((value){
        science = value.data['articles'];
        print(science.length);
        emit(NewsGetScienceDataSuccessfullyState());
      }).catchError((error){
        print('############# ERROR ############ ${error.toString()}');
        emit(NewsGetScienceDataErrorState(error: error.toString()));
      });
    }else{
      emit(NewsGetScienceDataSuccessfullyState());
    }
  }

  List<dynamic> search = [];

  void getSearch(String value){
    search = [];
    DioHelper.getData(
        path: 'v2/everything' ,
        queryParameters: {
          'q': '$value',
          'apiKey' : '60e04c04e8b14b41b6a9236646e72d71',
        }
    ).then((value){
      search = value.data['articles'];
      print(search.length);
      emit(NewsGetSearchDataSuccessfullyState());
    }).catchError((error){
      print('############# ERROR ############ ${error.toString()}');
      emit(NewsGetSearchDataErrorState(error: error.toString()));
    });
  }
}