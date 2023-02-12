import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/shared/cubit/cubit.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';

import '../../../shared/components/components.dart';


class NewTasksScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit , AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).tasks;

        return ListView.separated(
          separatorBuilder: (context , index)=> Container(
            height: 1 ,
            width: double.infinity,
            color: Colors.grey[300],
          ),
          itemBuilder: (context , index) => buildTaskItem(model: tasks[index]),
          itemCount: tasks.length,
        );
      },
    );
  }
}
