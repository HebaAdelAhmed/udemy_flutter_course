import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/shop_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/shop_app/cubit/states.dart';
import 'package:udemy_flutter/modules/shop_app/login/shop_login_screen.dart';
import 'package:udemy_flutter/modules/shop_app/search/search_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
      },
      builder: (context, state) {

        ShopCubit cubit = ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: (){
                  navigateTo(
                    context: context,
                    widget: SearchScreen(),
                  );
                },
                icon: Icon(
                  Icons.search
                ),
              ),
            ],
            title: Text(
              'Salla',
            ),
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.apps,
                ),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite
                ),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: 'Settings',
              ),
            ],
            onTap: (index){
              cubit.changeBottomIndex(index);
            },
            currentIndex: cubit.currentIndex,
          ),

        );
      },
    );
  }
}
