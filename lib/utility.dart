import 'package:database/task_type.dart';
import 'package:database/type_enum.dart';

List<TaskType> getTaskTypeList(){
  var list=[
    TaskType(image: 'assets/images/meditate.png', title: 'تمرکز', taskTypeEnum: TaskTypeEnum.focus),
    TaskType(image: 'assets/images/social_frends.png', title: 'میتینگ', taskTypeEnum: TaskTypeEnum.date),
    TaskType(image: 'assets/images/hard_working.png', title: 'کارزیاد', taskTypeEnum: TaskTypeEnum.working),
  ];

  return list;
}