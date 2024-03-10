import 'package:database/add_task_screen.dart';
import 'package:database/task.dart';
import 'package:database/task_type.dart';
import 'package:database/task_type_item.dart';
import 'package:database/utility.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:time_pickerr/time_pickerr.dart';

class EditTaskScreen extends StatefulWidget {
  EditTaskScreen({super.key, required this.task});

  Task task;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  FocusNode negahban1 = FocusNode();
  FocusNode negahban2 = FocusNode();

  TextEditingController? controllerTaskTitle;
  TextEditingController? controllerTaskSubTitle;

  final box = Hive.box<Task>('taskBox');
  DateTime? _time;
  int _selectedTaskTypeitem = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controllerTaskTitle = TextEditingController(text: widget.task.title);
    controllerTaskSubTitle = TextEditingController(text: widget.task.subTitle);

    negahban1.addListener(() {
      setState(() {});
    });

    negahban2.addListener(() {
      setState(() {});
    });

    var index = getTaskTypeList().indexWhere((element) {
      return element.taskTypeEnum == widget.task.taskType.taskTypeEnum;
    },);

    _selectedTaskTypeitem = index;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 44),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    controller: controllerTaskTitle,
                    decoration: InputDecoration(
                        floatingLabelStyle: TextStyle(color: Color(0xff18DAA3)),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        labelText: 'عنوان تسک',
                        labelStyle: TextStyle(
                            fontFamily: 'GM', fontSize: 20, color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide:
                                BorderSide(color: Color(0xffC5C5C5), width: 3)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide:
                                BorderSide(width: 3, color: Color(0xff18DAA3)))),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 44),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    controller: controllerTaskSubTitle,
                    maxLines: 2,
                    decoration: InputDecoration(
                        floatingLabelStyle: TextStyle(color: Color(0xff18DAA3)),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        labelText: 'توضیحات تسک',
                        labelStyle: TextStyle(
                            fontFamily: 'GM',
                            fontSize: 20,
                            color: negahban2.hasFocus
                                ? Color(0xff18DAA3)
                                : Color(0xffC5C5C5)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide:
                                BorderSide(color: Color(0xffC5C5C5), width: 3)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide:
                                BorderSide(width: 3, color: Color(0xff18DAA3)))),
                  ),
                ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: CustomHourPicker(
                  title: 'زمان تسک رو انتخاب کن',
                  negativeButtonText: 'حذف کن',
                  positiveButtonText: 'انتخاب زمان',
                  elevation: 2,
                  titleStyle: TextStyle(
                      color: Color(0xff18DAA3),
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  negativeButtonStyle: TextStyle(
                      color: Color.fromARGB(255, 218, 92, 24),
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  positiveButtonStyle: TextStyle(
                      color: Color(0xff18DAA3),
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  onPositivePressed: (context, time) {
                    _time=time;
                  },
                  onNegativePressed: (context) {},
                ),
              ),
              Container(
                height: 190,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: getTaskTypeList().length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedTaskTypeitem = index;
                        });
                      },
                      child: TaskTypeItemList(
                        taskType: getTaskTypeList()[index],
                        index: index,
                        selectedItemList: _selectedTaskTypeitem,
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff18DAA3),
                    minimumSize: Size(200, 48)),
                onPressed: () {
                  String taskTitle = controllerTaskTitle!.text;
                  String taskSubTitle = controllerTaskSubTitle!.text;
                  editTask(taskTitle, taskSubTitle);
                  Navigator.of(context).pop();
                },
                child: Text(
                  'ویرایش کردن تسک',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      )),
    );
  }

  editTask(String taskTitle, String taskSubTitle) {
    //add task
    widget.task.title = taskTitle;
    widget.task.subTitle = taskSubTitle;
    widget.task.time = _time!;
    widget.task.taskType = getTaskTypeList()[_selectedTaskTypeitem];

    widget.task.save();

/*     box.put(1,task);
     print(box.get(1)!.title);*/
  }



}


