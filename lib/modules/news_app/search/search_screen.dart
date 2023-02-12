import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/news_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/news_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/news_app/cubit/states.dart';

import '../../../shared/components/components.dart';

class SearchScreen extends StatelessWidget {

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit, NewsAppStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        NewsAppCubit cubit = NewsAppCubit.get(context);
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultTextFormField(
                      controller: searchController,
                      fieldName: 'Search',
                      keyboardType: TextInputType.text,
                      validation: (value) {
                        if (value!.isEmpty) {
                          return 'Search Must not be empty';
                        }
                        return null;
                      },
                      prefixIcon: Icons.search,
                      onChange: (value) {
                        cubit.getSearch(value);
                      }
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: cubit.search.length,
                    itemBuilder: (context , index){
                      return  buildArticleItem(
                        image: cubit.search[index]['urlToImage'],
                        context: context,
                        date: cubit.search[index]['publishedAt'],
                        title: cubit.search[index]['title'],
                        url: cubit.sports[index]['url']

                      );
                    },
                    separatorBuilder: (context , index){
                      return Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.black,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
