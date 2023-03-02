import 'package:mobx/mobx.dart';

import 'package:md_todo/modules/tasks/models/task.dart';
import 'package:md_todo/modules/tasks/repositories/task_repository.dart';

part 'task.store.g.dart';

abstract class _TaskStore with Store {
  @observable
  bool inLoading = false;

  @observable
  List<Task> tasks = [];
  
  @action
  Future<void> list() async {
    try {
      inLoading = true;
      tasks = await TaskRepository().list();
      inLoading = false;
    } on Exception {
      inLoading = false;
      rethrow;
    }
  }
  
  @action
  Future<void> create(Map<String, dynamic> data) async {
    try {
      await TaskRepository().create(data);
      await list();
    } on Exception {
      rethrow;
    }
  }

  @action
  Future<void> complete(String id) async {
    try {
      await TaskRepository().complete(id);
      // tasks.removeWhere((Task task) => task.id == id);
      tasks.clear();
    } on Exception {
      rethrow;
    }
  }
  
  @action
  Future<void> delete(String id) async {
    try {
      await TaskRepository().delete(id);
      tasks.removeWhere((Task task) => task.id == id);
    } on Exception {
      rethrow;
    }
  }
}

class TaskStore = _TaskStore with _$TaskStore;