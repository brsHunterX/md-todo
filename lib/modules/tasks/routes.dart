import 'package:flutter/material.dart';

import 'package:md_todo/modules/tasks/pages/task_list_page.dart';
import 'package:md_todo/modules/tasks/pages/task_create_page.dart';

class TaskRoutes {
  static const TASK_LIST = '/tasks/list';
  static const TASK_CREATE = '/tasks/create';

  static final routes = {
    TASK_LIST: (BuildContext context) => const TaskListPage(),
    TASK_CREATE: (BuildContext context) => const TaskCreatePage(),
  };
}