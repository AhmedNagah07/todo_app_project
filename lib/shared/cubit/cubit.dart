// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// import '../../model/todo_model.dart';
import '../../modules/archived_tasks/archived_tasks_screen.dart';
import '../../modules/done_tasks/done_tasks_screen.dart';
import '../../modules/new_tasks/new_tasks_screen.dart';

import 'states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());
  static AppCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen()
  ];

  List<String> titles = ['Tasks', 'Done Tasks', 'Archived Tasks'];

  bool isDark = false;

  void changeAppTheme({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
    } else {
      isDark = !isDark;
      Hive.box('settings').put('isDark', isDark);
    }

    emit(AppChangeThemeStates());
  }

  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavStates());
  }

  Database? database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

//   void createDatabase()  {
//     openDatabase(
//       'todo.db',
//       version: 1,
//       onCreate: (database, version) {
//         print('database created');
//         database
//             .execute(
//                 'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title VARCHAR,description VARCHAR ,date VARCHAR, time VARCHAR, status VARCHAR)')
//             .then((value) {
//           print('table created');
//         }).catchError((error) {
//           print('error when creating table ${error.toString()}');
//         });
//       },
//       onOpen: (database) {
//         print('database opened');
//         getFromDatabase(database);
//       },
//     ).then((value) {
  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
                'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title VARCHAR, description VARCHAR, date VARCHAR, time VARCHAR, status VARCHAR)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('error when creating table ${error.toString()}');
        });
      },
      onOpen: (database) {
        print('database opened');
        getFromDatabase(database);
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseStates());
    });
  }
//       database = value;
//       emit(AppCreateDatabaseStates());
//     });

// }
  void insertToDatabase({
    required String title,
    required String date,
    required String time,
    String description = '',
    // required String status,
  }) async {
    return await database?.transaction((txn) => txn
            .rawInsert(
                'INSERT INTO tasks(title, description,date, time, status) VALUES("$title", "$description","$date", "$time", "new")')
            .then((value) {
          print('$value inserted successfully');
          emit(AppInsertToDatabaseStates());
          // print('tasks : $tasks');
          getFromDatabase(database);
        }));
  }

  void getFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    // emit(AppGetDatabaseLoadingStates());

    database.rawQuery('SELECT * FROM tasks').then((value) {
      // tasks = value;
      // print('tasks : $tasks');

      value.forEach((element) {
        if (element['status'] == 'new')
          newTasks.add(element);
        else if (element['status'] == 'done')
          doneTasks.add(element);
        else
          archivedTasks.add(element);
        // print('element : $element');
      });
      emit(AppGetDatabaseLoadingStates());

      // emit(AppGetDatabaseStates());
    });
  }

  void updateDatabase({required int id, required String status}) async {
    database?.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id],
    ).then((value) {
      getFromDatabase(database);
      emit(AppUpdateDatabaseStates());
    });
  }

  void updateDatabaseInfo({
    required int id,
    required String title,
    required String date,
    required String time,
    required String description,
  }) async {
    database?.rawUpdate(
      'UPDATE tasks SET title = ?, date = ?, time = ?, description = ? WHERE id = ?',
      [title, date, time, description, id],
    ).then((value) {
      getFromDatabase(database);
      emit(AppUpdateDatabaseStates());
    });
  }

  void deleteFromDatabase({
    required int id,
  }) async {
    database?.rawDelete(
      'DELETE FROM tasks WHERE id = ?',
      [id],
    ).then((value) {
      getFromDatabase(database);
      emit(AppDeleteDatabaseStates());
    });
  }

// static const String databaseName = 'sqflite_ex.db';
// static const String tableName = 'tasks_ex';
// // final AsyncMemoizer memoizer = AsyncMemoizer();

// late Database db;
// List <TodoModel> todos = [];

// Future<void> initDatabase() async {
//   final dbFolder = await getDatabasesPath();

//   if (await Directory(dbFolder).exists()) {
//     await Directory(dbFolder).create(recursive: true);
//   }
//   final dbPath = join(dbFolder, databaseName);
//   db = await openDatabase(dbPath, version: 1,
//   onCreate: (db, version) async {
//     await db.execute(
//       'CREATE TABLE $tableName ('
//       'id INTEGER PRIMARY KEY, '
//       'title TEXT, '
//       'description TEXT, '
//       'date TEXT, '
//       'time TEXT, '
//       'isDone INTEGER)',
//     );

//   });

// }
// Future<void> getTodoItems() async {
//   final List<Map<String, dynamic>> maps = await db.query(tableName);
//   todos = List.generate(maps.length, (index) {
//     return TodoModel(
//       id: maps[index]['id'],
//       title: maps[index]['title'],
//       description: maps[index]['description'],
//       date: maps[index]['date'],
//       time: maps[index]['time'],
//       isDone: maps[index]['isDone'] == 1,
//     );
//   });
// }
// Future <void> insertTodoItem(TodoModel todo) async {
//  await db.transaction((txn) async {
//     await txn.insert(tableName, todo.toMap());
//   });
//   emit(AppInsertToDatabaseStates());
//   getTodoItems();
// }
}
