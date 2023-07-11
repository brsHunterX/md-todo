import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:md_todo/domain/entities/task_entity.dart';

import 'package:md_todo/domain/events/task_event.dart';
import 'package:md_todo/domain/repositories/task_repository.dart';
import 'package:md_todo/domain/states/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository _repository;
  
  TaskBloc(this._repository) : super(TaskIdleState()) {
    on<TaskListEvent>((event, emit) async {
      try {
        emit(TaskLoadingState());
        final List<Task> tasks = await _repository.list();
        
        if (tasks.isEmpty) {
          emit(TaskIdleState());
        } else {
          emit(TaskSuccessState(tasks: tasks));
        }
      } on Exception {
        emit(TaskFailureState(message: 'Failure to list task. Please try again.'));
      }
    });

    on<TaskCreateEvent>((event, emit) async {
      final String successMsg = '${event.dto.title} created successfully!';
      final String failuresMsg = 'Failure to create ${event.dto.title}. Please try again.';
      
      try {
        emit(TaskLoadingState());
        await _repository.create(event.dto);
        final List<Task> tasks = await _repository.list();
        emit(TaskSuccessState(tasks: tasks, message: successMsg));
      } on Exception {
        emit(TaskFailureState(message: failuresMsg));
      }
    });

    on<TaskDeleteEvent>((event, emit) async {
      const String successMsg = 'Task deleted successfully!';
      const String failuresMsg = 'Failure to delete task. Please try again.';
      
      try {
        emit(TaskLoadingState());
        await _repository.delete(event.id);
        final List<Task> tasks = await _repository.list();

        if (tasks.isEmpty) {
          emit(TaskIdleState());
        } else {
          emit(TaskSuccessState(tasks: tasks, message: successMsg));
        }
      } on Exception {
        emit(TaskFailureState(message: failuresMsg));
      }
    });

    on<TaskCompleteEvent>((event, emit) async {
      const String successMsg = 'Task completed successfully!';
      const String failuresMsg = 'Failure to complete task. Please try again.';

      try {
        emit(TaskLoadingState());
        await _repository.complete(event.id);
        final List<Task> tasks = await _repository.list();

        if (tasks.isEmpty) {
          emit(TaskIdleState());
        } else {
          emit(TaskSuccessState(tasks: tasks, message: successMsg));
        }
      } on Exception {
        emit(TaskFailureState(message: failuresMsg));
      }
    });
  }
}