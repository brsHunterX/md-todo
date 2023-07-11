import 'package:md_todo/domain/dtos/task_create_dto.dart';

sealed class TaskEvent {}

final class TaskLoadingEvent extends TaskEvent {}

final class TaskListEvent extends TaskEvent {}

final class TaskCreateEvent extends TaskEvent {
  final TaskCreateDTO dto;

  TaskCreateEvent({ required this.dto });
}

final class TaskDeleteEvent extends TaskEvent {
  final String id;
  
  TaskDeleteEvent({ required this.id });
}

final class TaskCompleteEvent extends TaskEvent {
  final String id;
  
  TaskCompleteEvent({ required this.id });
}