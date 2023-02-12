import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';
import '../../modules/toda_app/archive_tasks/archive_tasks.dart';
import '../../modules/toda_app/done_tasks/done_tasks.dart';
import '../../modules/toda_app/new_tasks/new_tasks.dart';


class AppCubit extends Cubit<AppStates>{

  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int index = 0;

  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchiveTasksScreen()
  ];

  List<String> title = [
    'New Tasks',
    'Done Tasks',
    'Archive Tasks',
  ];

  Database ? database;

  List<Map<dynamic , dynamic>> tasks = [];

  void changeIndex(int currentIndex){
    index = currentIndex;
    emit(AppChangeBottomNavBarState());
  }

  void createDatabase() async {
    database = await openDatabase(
        'todo.db',
        version: 1,
        onCreate: (database , version) {
          print('Database Created');
          database.execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY , title TEXT , data TEXT , time TEXT , status TEXT)'
          ).then((value){
            print('Table Created');
          }).catchError((error){
            print('Error in Create a Table ${error.toString()}');
          });
        },
        onOpen: (database) async{
          await getDateFromDatabase(database).then((value) {
            tasks = value;
            emit(AppGetDatabaseState());
          });
          print('Database Opened');
        }
    ).then((value){
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertFromDatabase({
    required String title ,
    required String date ,
    required String time ,
    required String status
  }) async{
    return await database?.transaction((transaction) async{
      transaction.rawInsert(
          'INSERT INTO tasks (title , data , time , status) VALUES ("$title" , "$date" , "$time" , "$status")'
      ).then((value){
        print('INSERT IN The TABLE in VALUE $value');
        emit(AppInsertDatabaseState());
        getDateFromDatabase(database).then((value) {
          tasks = value;
          print(tasks);
          emit(AppInsertDatabaseState());
          emit(AppGetDatabaseState());
        });
      }).catchError((error){
        print('ERROR in INSERTING In The TABLE ${error.toString()}');
      });
    });
  }

  Future <List<Map<dynamic , dynamic>>> getDateFromDatabase(database) async{
    return await database!.rawQuery('SELECT * FROM tasks');
  }

  // Future<int> updateDate({required String status , required int id}) async {
  //   return await database!.rawUpdate(
  //       'UPDATE tasks SET status = ? WHERE id = ?',
  //       ['$status', '$id']).then((value){
  //         emit(AppChangeUpdateDatabase());
  //   });
  // }

  bool isBottomSheetShown = false;

  void changeBottomSheetState(bool value){
    isBottomSheetShown = value;
    emit(AppChangeBottomSheetState());
  }

}