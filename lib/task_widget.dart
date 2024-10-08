import 'package:database/edit_task_screen.dart';
import 'package:database/task.dart';
import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

class TaskWidget extends StatefulWidget {
  TaskWidget({super.key, required this.task});

  Task task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isBoxChecked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isBoxChecked = widget.task.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return getTaskItem();
  }

  Widget getTaskItem() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isBoxChecked = !isBoxChecked;
          widget.task.isDone = isBoxChecked;
          widget.task.save();
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        height: 132,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: getMainContent(),
        ),
      ),
    );
  }

  Row getMainContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Transform.scale(
                    scale:1.4,
                    child: Checkbox(
                      value: isBoxChecked,
                      checkColor: Colors.white,
                      activeColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                  Text(widget.task.title),
                ],
              ),
              Text(
                widget.task.subTitle,
                overflow: TextOverflow.ellipsis,
              ),
              Spacer(),
              getTimeAndEditBadgs(),
            ],
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Image.asset(widget.task.taskType.image)
      ],
    );
  }

  Row getTimeAndEditBadgs() {
    return Row(
      children: [
        Container(
          width: 95,
          height: 30,
          decoration: BoxDecoration(
            color: Color(0xff18DAA3),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              children: [
                Text(
                  "${widget.task.time.hour}:${getMinUnderten(widget.task.time)}",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                SizedBox(
                  width: 10,
                ),
                Image.asset('assets/images/icon_time.png'),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return EditTaskScreen(
                  task: widget.task,
                );
              },
            ));
          },
          child: Container(
            width: 95,
            height: 30,
            decoration: BoxDecoration(
              color: Color(0xffE2F6F1),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'ویرایش',
                    style: TextStyle(color: Color(0xff18DAA3)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Image.asset('assets/images/icon_edit.png'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String getMinUnderten(DateTime time) {
    if (time.minute < 10) {
      return '0${time.minute}';
    } else {
      return time.minute.toString();
    }
  }
}
