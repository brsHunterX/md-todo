import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:md_todo/modules/tasks/routes.dart';
import 'package:md_todo/modules/tasks/models/task.dart';
import 'package:md_todo/modules/tasks/stores/task.store.dart';

import 'package:md_todo/app/widgets/app_logo.dart';
import 'package:md_todo/app/widgets/app_empty_state.dart';
import 'package:md_todo/modules/tasks/widgets/task_list_tile.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final TaskStore _store = TaskStore();

  @override
  void initState() {
    _store.list();
    super.initState();
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const AppLogo(size: 32.0),
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () => Navigator.of(context).pushNamed(TaskRoutes.TASK_CREATE),
    );
  }

  Widget _buildProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator()
    );
  }

  Widget _buildEmptyState() {
    return const AppEmptyState.icon(
      icon: Icons.checklist_rounded,
      message: 'You completed all tasks :D'
    );
  }

  Widget _buildList(List<Task> tasks) {
    return RefreshIndicator(
      onRefresh: _store.list,
      child: ListView.separated(
        itemCount: _store.tasks.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) => TaskListTile(task: _store.tasks[index]),
      ),
    );
  }

  Widget _buildBody() {
    return Observer(
      builder: (BuildContext _) {
        if (_store.inLoading) {
          return _buildProgressIndicator();
        }

        if (_store.tasks.isEmpty) {
          return _buildEmptyState();
        }
      
        return _buildList(_store.tasks);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: _buildFAB(),
      body: _buildBody(),
    );
  }
}
