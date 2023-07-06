import 'package:flutter/material.dart';

import 'package:md_todo/domain/services/locator_service.dart';
import 'package:md_todo/domain/entities/task_entity.dart';
import 'package:md_todo/domain/stores/task_store.dart';

class TaskListTile extends StatelessWidget {
  final Task task;

  const TaskListTile({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    final TaskStore store = LocatorService.locator<TaskStore>();

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
          store.complete(task.id);
        } else {
          store.delete(task.id);
        }
      },
      child: tile,
    );
  }
}