import 'package:database/task_type.dart';
import 'package:flutter/material.dart';

class TaskTypeItemList extends StatelessWidget {
  TaskTypeItemList({
    required this.taskType,
    required this.index,
    required this.selectedItemList,
    super.key,
  });

  TaskType taskType;

  int index;

  int selectedItemList;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: (selectedItemList == index) ? Color(0xff18DAA3) : Colors.white,
          border: Border.all(
              color: (selectedItemList == index) ? Colors.green : Colors.grey,
              width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: EdgeInsets.all(8),
      width: 140,
      child: Column(
        children: [
          Image.asset(taskType.image),
          Text(
            taskType.title,
            style: TextStyle(
              fontSize: 20,
              color: (selectedItemList == index)
                  ? Colors.white
                  : Colors.black,
            ),
          )
        ],
      ),
    );
  }
}