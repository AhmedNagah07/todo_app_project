// import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart' show DateFormat;
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/cubit/cubit.dart';

// import '../cubit/states.dart';
// import 'package:test_project/shared/cubit/cubit.dart';

// ignore: non_constant_identifier_names
Widget DefaultButton({
  double width = double.infinity,
  Color backgroundColor = Colors.blue,
  double radius = 10.0,
  required Function function,
  required String text,
  bool isUpperCase = true,
}) =>
    Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      width: width,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );

Widget DefaultFormField(
        {required TextEditingController controller,
        required TextInputType type,
        Function(String)? onSubmit,
        Function(String)? onChange,
        VoidCallback? onTap,
        Function? suffixPressed,
        required String? Function(String?) validate,
        required String label,
        required String hintText,
        required IconData prefix,
        IconData? suffix,
        bool isPassword = false,
        bool isClickable = true,
        Color cursorErrorColor = Colors.red}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      validator: validate,
      onTap: onTap,
      enabled: isClickable,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: Icon(suffix),
        border: const OutlineInputBorder(),
        hintText: hintText,
      ),
    );
Widget buildTaskItem(Map model, context) => Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            label: 'Delete',
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(20.0),
            icon: Icons.delete,
            onPressed: (context) {
              AppCubit.get(context).deleteFromDatabase(id: model['id']);
            },
          )
        ],
      ),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            label: 'Archeive',
            backgroundColor: Colors.green,
            borderRadius: BorderRadius.circular(20.0),
            icon: Icons.archive,
            // autoClose: true,
            onPressed: (context) {
              AppCubit.get(context)
                  .updateDatabase(status: 'archived', id: model['id']);
            },
          )
        ],
      ),
      child: InkWell(
        onLongPress: () => showDialog(
          context: context,
          builder: (context) {
            var titleController = TextEditingController(text: model['title']);
            var descriptionController =
                TextEditingController(text: model['description']);
            var dateController = TextEditingController(text: model['date']);
            var timeController = TextEditingController(text: model['time']);
            return AlertDialog(
              title: const Text('Edit Task'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DefaultFormField(
                      controller: titleController,
                      type: TextInputType.text,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Title must not be empty';
                        }
                        return null;
                      },
                      label: 'Task Title',
                      hintText: 'Enter task title',
                      prefix: Icons.title,
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      controller: descriptionController,
                      maxLines: 3,

                      keyboardType: TextInputType.multiline,
                      // validator: (String? value) {
                      //   if (value!.isEmpty) {
                      //     return 'Description must not be empty';
                      //   }
                      //   return null;
                      // },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Task Description',
                        hintText: 'Enter task description',
                        prefixIcon: Icon(Icons.description),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    DefaultFormField(
                      controller: dateController,
                      type: TextInputType.datetime,
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101),
                        ).then((value) {
                          if (value != null) {
                            dateController.text =
                                DateFormat.yMMMd().format(value);
                          }
                        });
                      },
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Date must not be empty';
                        }
                        return null;
                      },
                      label: 'Task Date',
                      hintText: 'Enter task date',
                      prefix: Icons.calendar_today,
                    ),
                    const SizedBox(height: 10.0),
                    DefaultFormField(
                      controller: timeController,
                      type: TextInputType.datetime,
                      onTap: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((value) {
                          if (value != null) {
                            timeController.text = value.format(context);
                          }
                        });
                      },
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Time must not be empty';
                        }
                        return null;
                      },
                      label: 'Task Time',
                      hintText: 'Enter task time',
                      prefix: Icons.watch_later_outlined,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    AppCubit.get(context).updateDatabaseInfo(
                      id: model['id'],
                      title: titleController.text,
                      description: descriptionController.text,
                      date: dateController.text,
                      time: timeController.text,
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        ),
        onTap: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              '${model['title']}',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pacifico',
                  color: AppCubit.get(context).isDark
                      ? Colors.deepOrange
                      : const Color.fromARGB(255, 236, 219, 84)),
            ),
            content: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['date']} at ${model['time']}',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '${model['description']}',
                    // maxLines: 5,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            scrollable: true,
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK')),
            ],
          ),
        ),
        child: (Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: AppCubit.get(context).isDark
                    ? [
                        Color.fromARGB(255, 250, 102, 61),
                        Color.fromARGB(255, 250, 102, 66)
                      ]
                    : [Color(0xfffae53d), Color.fromARGB(255, 233, 238, 188)]),
            borderRadius: BorderRadius.circular(20.0),
            color: const Color.fromARGB(255, 234, 208, 17),
          ),
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateDatabase(status: 'done', id: model['id']);
                },
                icon: Icon(
                  Icons.check_box_rounded,
                  size: 20,
                  color: AppCubit.get(context).isDark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  '${model['title']}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Pacifico",
                    decoration: model['status'] == 'done'
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    color: model['status'] == 'done'
                        ? const Color.fromARGB(255, 192, 188, 188)
                        : null,
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );

Widget buildItem(tasks) => ListView.separated(
    itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(10.0),
          child: buildTaskItem(tasks[index], context),
        ),
    separatorBuilder: (context, index) => Divider(
          height: 1.0,
          color: Colors.grey[300],
          thickness: 1.0,
          indent: 40.0,
          endIndent: 40.0,
        ),
    itemCount: tasks.length);
