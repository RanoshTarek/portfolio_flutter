import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class TodoHomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return TodoCubit()..createDatabase();
      },
      child: BlocConsumer<TodoCubit, TodoStates>(
        listener: (BuildContext context, state) {
          if (state is TodoInsertIntoDatabase) {
            print("done");
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, state) {
          TodoCubit appCubit = TodoCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(appCubit.titles[appCubit.currentIndex]),
            ),
            body: ConditionalBuilder(
              condition: false,
              builder: (context) => Center(child: CircularProgressIndicator()),
              fallback: (context) =>
                  appCubit.bottomNavScreen[appCubit.currentIndex],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                print("plus");
                if (appCubit.isBottomSheetOpen) {
                  if (formKey.currentState.validate()) {
                    appCubit
                        .insertIntoDatabase(titleController.text,
                            dateController.text, timeController.text)
                        .then((value) {})
                        .catchError((onError) => print(onError));
                  }
                } else {
                  scaffoldKey.currentState
                      .showBottomSheet((context) => Container(
                            color: Colors.grey[200],
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    defaultFromField(
                                        controller: titleController,
                                        textInputType: TextInputType.text,
                                        prefixIcon: Icon(Icons.title),
                                        validate: (String value) {
                                          if (value.isEmpty) {
                                            return 'title must not be empty';
                                          }
                                          return null;
                                        },
                                        labelText: 'Task Title'),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    defaultFromField(
                                        controller: dateController,
                                        textInputType: TextInputType.datetime,
                                        prefixIcon:
                                            Icon(Icons.calendar_today_outlined),
                                        onTap: () {
                                          showDatePicker(
                                                  context: context,
                                                  firstDate: DateTime.now(),
                                                  initialDate: DateTime.now(),
                                                  lastDate: DateTime.parse(
                                                      '2021-08-01'))
                                              .then((value) => {
                                                    dateController.text =
                                                        DateFormat.yMMMd()
                                                            .format(value)
                                                  });
                                        },
                                        validate: (String value) {
                                          if (value.isEmpty) {
                                            return 'date must not be empty';
                                          }
                                          return null;
                                        },
                                        labelText: 'Task Date'),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    defaultFromField(
                                        controller: timeController,
                                        textInputType: TextInputType.datetime,
                                        prefixIcon:
                                            Icon(Icons.watch_later_outlined),
                                        onTap: () {
                                          showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now())
                                              .then((value) =>
                                                  timeController.text =
                                                      value.format(context));
                                        },
                                        validate: (String value) {
                                          if (value.isEmpty) {
                                            return 'time must not be empty';
                                          }
                                          return null;
                                        },
                                        labelText: 'Task Time')
                                  ],
                                ),
                              ),
                            ),
                          ))
                      .closed
                      .then((value) {
                    appCubit.setBottomNavStatus(false);
                  });
                  appCubit.setBottomNavStatus(true);
                }
              },
              child: Icon(appCubit.isBottomSheetOpen ? Icons.add : Icons.edit),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: appCubit.currentIndex,
              onTap: (value) {
                appCubit.setBottomNavIndex(value);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Tasks"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle), label: "Done"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive), label: "Archive"),
              ],
            ),
          );
        },
      ),
    );
  }
}
