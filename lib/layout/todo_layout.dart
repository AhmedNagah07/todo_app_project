import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:intl/intl.dart';
// import '../shared/components/constants.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

// ignore: must_be_immutable
class TodoLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var descrptionController = TextEditingController();

  TodoLayout({super.key});
  // List<Map> tasks = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppInsertToDatabaseStates) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          // backgroundColor: Colors.white,

          key: scaffoldKey,
          appBar: AppBar(
            title: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  cubit.titles[cubit.currentIndex],
                  textStyle: TextStyle(
                    color: cubit.isDark ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ],
              totalRepeatCount: 1,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    cubit.changeAppTheme();
                  },
                  icon: Icon(cubit.isDark
                      ? Icons.light_mode_outlined
                      : Icons.dark_mode_outlined))
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          floatingActionButton: FloatingActionButton(
            tooltip: "Add new task",
            shape: const CircleBorder(),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => Dialog(
                          // backgroundColor: Colors.transparent,

                          child: Container(
                        padding: const EdgeInsets.all(20.0),
                        // height: 150,
                        // width: 150,
                        color: cubit.isDark ? Colors.grey[500] : Colors.white,
                        child: Form(
                            key: formKey,
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  verticalDirection: VerticalDirection.down,
                                  children: [
                                    DefaultFormField(
                                        controller: titleController,
                                        type: TextInputType.text,
                                        hintText: 'Task Title',
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'title must not be empty';
                                          }
                                          return null;
                                        },
                                        label: 'Task Title',
                                        prefix: Icons.title),
                                    // const SizedBox(
                                    //   height: 15.0,
                                    // ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    DefaultFormField(
                                        controller: timeController,
                                        type: TextInputType.datetime,
                                        hintText: 'Task Time',
                                        onTap: () {
                                          showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now())
                                              .then((value) {
                                            if (value != null) {
                                              return timeController.text = value
                                                  .format(context)
                                                  .toString();
                                            }
                                          });
                                        },
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'time must not be empty';
                                          }
                                          return null;
                                        },
                                        label: 'Task Time',
                                        prefix: Icons.watch_later_outlined),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    DefaultFormField(
                                        controller: dateController,
                                        type: TextInputType.datetime,
                                        hintText: 'Task Date',
                                        label: 'Task Date',
                                        onTap: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime.now().add(
                                                const Duration(
                                                    days:
                                                        365)), // Set lastDate to a year from now
                                          ).then((value) {
                                            if (value != null) {
                                              dateController.text =
                                                  DateFormat.yMMMd()
                                                      .format(value);
                                            }
                                          });
                                        },
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'date must not be empty';
                                          }
                                          return null;
                                        },
                                        prefix: Icons.calendar_month),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    TextFormField(
                                      maxLines: 3,
                                      controller: descrptionController,
                                      decoration: InputDecoration(
                                        labelText: 'Task Description',
                                        prefixIcon: Icon(Icons.description),
                                        border: const OutlineInputBorder(),
                                        hintText: 'Task Description',
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    DefaultButton(
                                        backgroundColor: cubit.isDark
                                            ? Colors.deepOrange
                                            : Colors.yellow,
                                        function: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            cubit.insertToDatabase(
                                                title: titleController.text,
                                                description:
                                                    descrptionController.text,
                                                date: dateController.text,
                                                time: timeController.text);
                                          }
                                        },
                                        text: 'Insert Task')
                                  ]),
                            )
                            //
                            ),
                      )));
            },
            child: Icon(Icons.add),
          ),

          bottomNavigationBar: BottomNavigationBar(
              elevation: 20.0,
              // mouseCursor: MouseCursor.defer,
              landscapeLayout: BottomNavigationBarLandscapeLayout.centered,

              // type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              showSelectedLabels: false,
              selectedIconTheme: IconThemeData(
                size: 30.0,
              ),
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline), label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: 'Archived')
              ]),
        );
      },
    );
  }
}
