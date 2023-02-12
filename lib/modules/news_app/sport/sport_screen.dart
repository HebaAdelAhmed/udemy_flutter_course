import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/news_app/cubit/cubit.dart';
import '../../../layout/news_app/cubit/states.dart';
import '../../../shared/components/components.dart';



class SportScreen extends StatelessWidget {
  const SportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit , NewsAppStates>(
      listener: (context , state) {

      },
      builder: (context, state) {
        NewsAppCubit cubit = NewsAppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.sports.length > 0,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            separatorBuilder: (context , index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 1,
                  width: double.infinity,
                ),
              );
            },
            itemBuilder: (context , index) {
              return buildArticleItem(
                context: context,
                  image: cubit.sports[index]['urlToImage'] ,
                  title: cubit.sports[index]['title'] ,
                  date: cubit.sports[index]['publishedAt'],
                  url: cubit.sports[index]['url']
              );
            },
            itemCount: cubit.business.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },

    );
  }
}
