import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:todo_app/modules/done_tasks/done_tasks_screen.dart';
import 'package:todo_app/modules/new_tasks/new_tasks_screen.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/components/constants.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

class HomeLayoutScreen extends StatelessWidget {
 




  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var _formKey = GlobalKey<FormState>();
  var _titleController = TextEditingController();
  var _dateController = TextEditingController();
  var _timeController = TextEditingController();

  bool _isBottomSheetOpened = false;
  IconData _fabIcon = Icons.edit;
  bool _isDone = false;

  // Future<void> _insertDataToDB({String title, String date, String time}) async {
  //   await _database.transaction((txn) {
  //     txn
  //         .rawInsert(
  //             'INSERT INTO $_tableName(title, date, time, status) VALUES("$title", "$date", "$time", "New Task")')
  //         .then((value) => print('$value --new task added successfully!'))
  //         .catchError((err) => print(
  //             '--AN ERROR OCCURED WHILE ADDING A NEW TASK TO THE DATABASE'));
  //     return null;
  //   });
  // }

  // Future<List<Map<String, dynamic>>> _getDataFromDB(Database database) async =>
  //     await database.rawQuery('SELECT * FROM $_tableName');

  // void _clearData() {
  //   _titleController.clear();
  //   _timeController.clear();
  //   _dateController.clear();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _createDB();
  // }

  // @override
  // void dispose() {
  //   _titleController.dispose();
  //   _timeController.dispose();
  //   _dateController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit _cubit = AppCubit.get(context);
          return Scaffold(
            key: _scaffoldKey,
            backgroundColor: _cubit.bgColors[_cubit.currentIndx],
            appBar: AppBar(
              title: Text(_cubit.titles[_cubit.currentIndx]),
            ),
            body: (true)
                ? _cubit.screens[_cubit.currentIndx]
                : Center(
                    child: CircularProgressIndicator(),
                  ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (_isBottomSheetOpened) {
                  if (_formKey.currentState.validate()) {
                    // _insertDataToDB(
                    //   title: _titleController.text,
                    //   date: _dateController.text,
                    //   time: _timeController.text,
                    // ).then((_) async {
                    //   _getDataFromDB(_database).then((value) {
                    //     _clearData();
                    //     Navigator.pop(context);
                    //     // setState(() {
                    //     //   _isBottomSheetOpened = false;
                    //     //   _fabIcon = Icons.edit;

                    //     //   todoTasks = value;
                    //     //   print(todoTasks);
                    //     // });
                    //   });
                    // });
                  }
                } else {
                  _scaffoldKey.currentState
                      .showBottomSheet(
                        (context) => Container(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                buildDefaultFormField(
                                  controller: _titleController,
                                  type: TextInputType.text,
                                  validate: (value) {
                                    if (value.isEmpty)
                                      return 'title must not be empty';
                                  },
                                  label: 'Task Title',
                                  prefix: Icons.title,
                                ),
                                SizedBox(height: 12),
                                buildDefaultFormField(
                                  controller: _timeController,
                                  type: TextInputType.datetime,
                                  validate: (value) {
                                    if (value.isEmpty)
                                      return 'time must not be empty';
                                  },
                                  label: 'Task Time',
                                  prefix: Icons.watch_later_outlined,
                                  readOnly: true,
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then(
                                      (value) => _timeController.text =
                                          value.format(context).toString(),
                                    );
                                  },
                                ),
                                SizedBox(height: 12),
                                buildDefaultFormField(
                                  controller: _dateController,
                                  type: TextInputType.datetime,
                                  validate: (value) {
                                    if (value.isEmpty)
                                      return 'date must not be empty';
                                  },
                                  label: 'Task Date',
                                  prefix: Icons.calendar_today,
                                  readOnly: true,
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2022-08-15'),
                                    ).then(
                                      (value) => _dateController.text =
                                          DateFormat.yMMMd().format(value),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .closed
                      .then((value) {
                    // setState(() {
                    //   _isBottomSheetOpened = false;
                    //   _fabIcon = Icons.edit;
                    // });
                  });
                  // setState(() {
                  //   _isBottomSheetOpened = true;
                  //   _fabIcon = Icons.add;
                  // });
                }
              },
              child: Icon(_fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _cubit.currentIndx,
              onTap: (indx) {
                _cubit.changeIndex(indx);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline),
                    label: 'Done Tasks'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined),
                    label: 'Archived Tasks'),
              ],
            ),
          );
        },
      ),
    );
  }
}
