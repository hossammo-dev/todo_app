import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:todo_app/modules/done_tasks/done_tasks_screen.dart';
import 'package:todo_app/modules/new_tasks/new_tasks_screen.dart';
import 'package:todo_app/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitState());

  static AppCubit get(context) => BlocProvider.of(context);

  //CUBIT DATA//

  int _currentIndx = 0;
  int get currentIndx => _currentIndx;

  List<Widget> _screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<Widget> get screens => _screens;

  List<String> _titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
  List<String> get titles => _titles;

  List<Color> _bgColors = [
    Colors.grey[100],
    Colors.white,
    Colors.white,
  ];
  List<Color> get bgColors => _bgColors;

  Database _database;
  Database get database => _database;
  final String _tableName = 'Todo';

  //CUBIT METHODS//

  void changeIndex(int indx) {
    _currentIndx = indx;
    emit(AppChangeBottomNavBarIndxState());
  }

  void createDB() async {
    ///first step -> create the database
    _database = await openDatabase('todo.db', version: 1,
        onCreate: (database, version) async {
      ///second step -> create the table
      print('--DATABASE CREATED--');
      await database.execute(
          'CREATE TABLE $_tableName (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)');
      print('--TABLE CREATED--');
    }, onOpen: (database) async {
      // todoTasks = await _getDataFromDB(database);
      // await _getDataFromDB(database).then((value) {
      //   // setState(() {
      //   //   todoTasks = value;
      //   //   _isDone = true;
      //   // });
      // });
      print('--DATABASE OPENED--');
      // print(todoTasks);
    });
    emit(AppCreateDatabaseState());
  }
}
