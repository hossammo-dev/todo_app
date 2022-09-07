import 'package:flutter/material.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/components/constants.dart';

class NewTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: todoTasks.isEmpty,
      builder: (context) => Center(
        child: Image.asset(
          'assets/images/task.jpg',
          width: 300,
          height: 300,
        ),
      ),
      // builder: (context) => Center(child: CircularProgressIndicator()),
      fallback: (context) => ListView.separated(
          itemBuilder: (context, indx) => buildTasksList(todoTasks[indx]),
          separatorBuilder: (context, indx) => Container(
            height: 1.5,
            width: double.infinity,
            color: Colors.grey[300],
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
          ),
          itemCount: todoTasks.length),
    );
  }
}
