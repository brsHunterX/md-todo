import 'package:flutter/material.dart';
import 'package:md_todo/domain/blocs/task_bloc.dart';
import 'package:md_todo/domain/events/task_event.dart';

import 'package:md_todo/domain/services/locator_service.dart';
import 'package:md_todo/domain/entities/task_entity.dart';

class TaskListTile extends StatelessWidget {
  final Task task;
  final TaskBloc _bloc = LocatorService.locator<TaskBloc>();

  TaskListTile({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {

    final Container background = Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(16.0),
      color: Theme.of(context).colorScheme.primaryContainer,
      child: const Icon(Icons.check_box_rounded),
    );
    
    final Container sBackground = Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.all(16.0),
      color: Theme.of(context).colorScheme.errorContainer,
      child: const Icon(Icons.delete_rounded),
    );

    final ListTile tile = ListTile(
      title: Text(task.title),
      subtitle: Text(task.body),
    );

    return Dismissible(
      key: Key(task.id),
      background: background,
      secondaryBackground: sBackground,
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.startToEnd) {
          _bloc.add(TaskCompleteEvent(id: task.id));
        } else {
          _bloc.add(TaskDeleteEvent(id: task.id));
        }
      },
      child: tile,
    );
  }
}