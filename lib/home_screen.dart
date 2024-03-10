import 'package:database/add_task_screen.dart';
import 'package:database/task.dart';
import 'package:database/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String inputText = '';
  var controller = TextEditingController();

  var box = Hive.box('names');

  bool isChecked = false;

  var taskBox = Hive.box<Task>('taskBox');

  bool isFabVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: Center(
          child: ValueListenableBuilder(
        valueListenable: taskBox.listenable(),
        builder: (context, value, child) {
          return NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              setState(() {
                if (notification.direction == ScrollDirection.forward) {
                  isFabVisible = true;
                }
                if (notification.direction == ScrollDirection.reverse) {
                  isFabVisible = false;
                }
              });
              return true;
            },
            child: ListView.builder(
              itemCount: taskBox.values.length,
              itemBuilder: (context, index) {
                var task = taskBox.values.toList()[index];
                print (task.taskType.title);
                return getListItem(task);
              },
            ),
          );
        },
      )),
      floatingActionButton: Visibility(
        visible: isFabVisible,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return AddTaskScreen();
              },
            ));
          },
          backgroundColor: Color(0xff18DAA3),
          child: Image.asset('assets/images/icon_add.png'),
        ),
      ),
    );
  }

  Widget  getListItem(Task task) {
    return Dismissible(
      key: UniqueKey(),
        onDismissed: (direction){
        task.delete();
        },
        child: TaskWidget(task: task));
  }
}
