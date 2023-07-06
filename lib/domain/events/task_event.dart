sealed class TaskEvent {}

final class TaskLoadingEvent extends TaskEvent {}

final class TaskListEvent extends TaskEvent {}

final class TaskCreateEvent extends TaskEvent {
  final Map<String, dynamic> data;

  TaskCreateEvent({ required this.data });
}

final class TaskDeleteEvent extends TaskEvent {
  final String id;
  
  TaskDeleteEvent({ required this.id });
}

final class TaskCompleteEvent extends TaskEvent {
  final String id;
  
  TaskCompleteEvent({ required this.id });
}