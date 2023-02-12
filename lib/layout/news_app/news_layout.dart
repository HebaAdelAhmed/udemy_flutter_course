import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/news_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/news_app/cubit/states.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

import '../../modules/news_app/search/search_screen.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsAppCubit()..getBusinessData(),
      child: BlocConsumer<NewsAppCubit , NewsAppStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          NewsAppCubit cubit = NewsAppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                  'News App'
              ),
              actions: [
                IconButton(
                  onPressed: (){
                    navigateTo(
                      context: context,
                      widget: SearchScreen()
                    );
                  },
                  icon: Icon(
                      Icons.search
                  ),
                ),
                IconButton(
                  onPressed: (){
                    cubit.changeThemeMode();
                  },
                  icon: Icon(
                    cubit.isDark? Icons.brightness_4_outlined : Icons.brightness_7,
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeCurrentIndex(index);
              },
              items: cubit.bottomItems,
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
