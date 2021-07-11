import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_app/layout/todo_layout/cubit/cubit.dart';
import 'package:first_app/layout/todo_layout/cubit/states.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/components/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArchiveTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
      builder: (BuildContext context, state) {
        return ConditionalBuilder(
          condition: TodoCubit.get(context).archivedTasks.length > 0,
          builder: (BuildContext context) {
            return ListView.separated(
                itemBuilder: (context, index) => taskBuilder(
                    TodoCubit.get(context).archivedTasks[index], context),
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 1,
                  );
                },
                itemCount: TodoCubit.get(context).archivedTasks.length);
          },
          fallback: (context) {
            return Center(
                child: Text(
              "No Tasks Available",
              style: TextStyle(fontSize: 22, color: Colors.grey),
            ));
          },
        );
      },
      listener: (BuildContext context, state) {},
    );
    return taskConsumerBuilder(TodoCubit.get(context).archivedTasks);
  }
}
