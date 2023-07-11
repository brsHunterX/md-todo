import 'package:md_todo/domain/entities/task_entity.dart';

sealed class TaskState {
  final List<Task> tasks;
  String? message;

  TaskState({ required this.tasks, this.message });
}

final class TaskIdleState extends TaskState {
  TaskIdleState({ super.message = 'You completed all tasks :D' }) : super(tasks: []);
}

final class TaskLoadingState extends TaskState {
  TaskLoadingState() : super(tasks: []);
}

final class TaskSuccessState extends TaskState {
  TaskSuccessState({ required super.tasks, super.message });
}

final class TaskFailureState extends TaskState {
  TaskFailureState({super.message}) : super(tasks: []);
}