import 'package:bloc/bloc.dart';
import 'package:first_app/layout/todo_layout/cubit/states.dart';
import 'package:first_app/modules/todo_app/archive_tasks/archive_task_screen.dart';
import 'package:first_app/modules/todo_app/done_tasks/done_task_screen.dart';
import 'package:first_app/modules/todo_app/new_tasks/new_task_screen.dart';
import 'package:first_app/shared/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class TodoCubit extends Cubit<TodoStates> {
  int currentIndex = 0;
  Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  var isBottomSheetOpen = false;
  List<String> titles = ["New Task", "Done Task", "Archive Task"];
  List<Widget> bottomNavScreen = [
    NewTaskScreen(),
    DoneTaskScreen(),
    ArchiveTaskScreen()
  ];

  TodoCubit() : super(TodoInitialState());

  static TodoCubit get(context) => BlocProvider.of(context);

  void setBottomNavIndex(int index) {
    currentIndex = index;
    emit(TodoSetBottomNavigationState());
  }

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (db, version) {
        print("database created");
        db
            .execute(
                "CREATE TABLE `tasks` (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)")
            .then((value) {})
            .catchError((onError) {
          print("database onError");
        });
      },
      onOpen: (db) {
        getDataFromDatabase(db);
        print("database onOpen");
      },
    ).then((value) {
      database = value;
      emit(TodoDatabaseCreated());
    });
  }

  getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    database.rawQuery("SELECT * FROM tasks").then((tasks) {
      tasks.forEach((task) {
        if (task['status'] == TASK_NEW) {
          newTasks.add(task);
        } else if (task['status'] == TASK_DONE) {
          doneTasks.add(task);
        } else if (task['status'] == TASK_ARCHIVE) {
          archivedTasks.add(task);
        }
      });
      emit(TodoGetTaskListFromDatabase());
    });
  }

  insertIntoDatabase(String title, String date, String time) {
    database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","new")')
          .then((value) => print("done $value"))
          .catchError((onError) => print(onError));
    }).then((value) {
      isBottomSheetOpen = false;
      getDataFromDatabase(database);
      emit(TodoInsertIntoDatabase());
    });
    return null;
  }

  updateFromDatabase(String status, int id) {
    database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(TodoUpdateFromDatabase());
    });
  }

  deleteFromDatabase(int id) {
    database.rawDelete('DELETE FROM tasks WHERE id = $id').then((value) {
      getDataFromDatabase(database);
      emit(TodoDeleteFromDatabase());
    });
  }

  void setBottomNavStatus(bool isVisible) {
    isBottomSheetOpen = isVisible;
    emit(TodoBottomSheetVisibilityState());
  }
}
