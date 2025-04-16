import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/layout/todo_layout.dart';
import 'package:todo_app/shared/styles/themes.dart';
// import 'package:hive_flutter/hive_flutter.dart';

import 'shared/cubit/cubit.dart';
import 'shared/cubit/states.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('settings');
  bool isDark = Hive.box('settings').get('isDark', defaultValue: false);
  runApp(MyApp(isDark: isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp({required this.isDark});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase()..changeAppTheme(fromShared: isDark),

      
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          // if (state is AppInsertToDatabaseStates) {
          //   Navigator.pop(context);
          // }
        },
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,    
         
          home:  TodoLayout(),
          
        ),
      ),
    );
  }
}
