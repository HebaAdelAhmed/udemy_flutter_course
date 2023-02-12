import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/cubit/cubit.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {

  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit , AppStates>(
        listener: (context, state) {

        },
        builder: (context , state) {

          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                cubit.title[cubit.index],
              ),
            ),
            body: cubit.tasks.length <= 0? Center(child: CircularProgressIndicator()) : cubit.screens[cubit.index],
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if(cubit.isBottomSheetShown){
                  if(formKey.currentState!.validate()){
                    cubit.insertFromDatabase(
                        title: titleController.text ,
                        date: dateController.text ,
                        time: timeController.text ,
                        status: 'done'
                    );
                    Navigator.pop(context);
                    cubit.changeBottomSheetState(false);
                  }
                }else{
                  scaffoldKey.currentState?.showBottomSheet((context) => Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            defaultTextFormField(
                              prefixIcon: Icons.title,
                              validation: (value){
                                if(value!.isEmpty){
                                  return 'Title Must Not be Empty';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              fieldName: 'Title',
                              controller: titleController,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            defaultTextFormField(
                              onTap: (){
                                showTimePicker(
                                  context: context ,
                                  initialTime: TimeOfDay.now(),).then(
                                        (value){
                                      timeController.text = value!.format(context);
                                    });
                              },
                              prefixIcon: Icons.watch_later_outlined,
                              validation: (value){
                                if(value!.isEmpty){
                                  return 'Time Must Not be Empty';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.datetime,
                              fieldName: 'Time',
                              controller: timeController,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            defaultTextFormField(
                              onTap: (){
                                showDatePicker(
                                  context: context ,
                                  initialDate: DateTime.now(),
                                  lastDate: DateTime.parse('2023-05-03'),
                                  firstDate: DateTime.now(),
                                ).then((value) {
                                  if(value != null){
                                    dateController.text =  DateFormat.yMMMd(value).toString();
                                  }
                                  else{
                                    dateController.text = DateFormat.yMMMd(value).locale.toString();
                                  }
                                }).catchError((error){
                                  dateController.text = '2022 - 12 - 10';
                                  print('There is an ERROR ###########################');
                                });
                              },
                              prefixIcon: Icons.date_range_outlined,
                              validation: (value){
                                if(value!.isEmpty){
                                  return 'Date Must Not be Empty';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.datetime,
                              fieldName: 'Date',
                              controller: dateController,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                      elevation: 15.5
                  ).closed.then((value) {
                    cubit.changeBottomSheetState(false);
                  });
                  cubit.changeBottomSheetState(true);
                }
              },
              child: cubit.isBottomSheetShown ? Icon(Icons.add) : Icon(Icons.edit),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.index,
              onTap: (value){
                cubit.changeIndex(value);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu,
                  ),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.check_circle_outline,
                  ),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.archive_outlined,
                  ),
                  label: 'Archive',
                ),
              ],
            ),
          );
        },

      ),
    );
  }

  Future<String> getName() async{
    return 'Ahmed Ali';
  }



}
