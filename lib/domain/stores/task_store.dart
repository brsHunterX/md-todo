// flutter packages pub run build_runner watch --delete-conflicting-outputs
import 'package:mobx/mobx.dart';

import 'package:md_todo/domain/states/task_state.dart';
import 'package:md_todo/domain/entities/task_entity.dart';
import 'package:md_todo/domain/repositories/task_repository.dart';

part 'task_store.g.dart';

abstract class _TaskStore with Store {
  final TaskRepository _repository;

  _TaskStore(
    this._repository,
  );

  @observable
  TaskState state = TaskIdleState();
  
  @action
  Future<void> list() async {
    try {
      state = TaskLoadingState();
      final List<Task> tasks = await _repository.list();
      
      if (tasks.isEmpty) {
        state = TaskIdleState();
      } else {
        state = TaskSuccessState(tasks: tasks);
      }
    } on Exception {
      state = TaskFailureState(message: 'Failure to list task. Please try again.');
    }
  }
  
  @action
  Future<void> create(Map<String, dynamic> data) async {
    try {
      state = TaskLoadingState();
      await _repository.create(data);
      final List<Task> tasks = await _repository.list();
      state = TaskSuccessState(tasks: tasks);
    } on Exception {
      state = TaskFailureState(message: 'Failure to create task. Please try again.');
    }
  }

  @action
  Future<void> delete(String id) async {
    try {
      state = TaskLoadingState();
      await _repository.delete(id);
      final List<Task> tasks = await _repository.list();

      if (tasks.isEmpty) {
        state = TaskIdleState();
      } else {
        state = TaskSuccessState(tasks: tasks);
      }
    } on Exception {
      state = TaskFailureState(message: 'Failure to delete task. Please try again.');
    }
  }

  @action
  Future<void> complete(String id) async {
    try {
      state = TaskLoadingState();
      await _repository.complete(id);
      final List<Task> tasks = await _repository.list();

      if (tasks.isEmpty) {
        state = TaskIdleState();
      } else {
        state = TaskSuccessState(tasks: tasks);
      }
    } on Exception {
      state = TaskFailureState(message: 'Failure to complete task. Please try again.');
    }
  }
}

class TaskStore = _TaskStore with _$TaskStore;