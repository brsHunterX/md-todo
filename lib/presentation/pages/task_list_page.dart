import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:md_todo/domain/states/task_state.dart';
import 'package:md_todo/domain/stores/task_store.dart';
import 'package:md_todo/domain/entities/task_entity.dart';
import 'package:md_todo/domain/services/locator_service.dart';

import 'package:md_todo/presentation/routes.dart';
import 'package:md_todo/presentation/widgets/app_logo.dart';
import 'package:md_todo/presentation/widgets/task_list_tile.dart';
import 'package:md_todo/presentation/widgets/app_empty_state.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final TaskStore _store = LocatorService.locator<TaskStore>();

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
      onPressed: () => Navigator.of(context).pushNamed(Routes.TASK_CREATE),
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
        itemCount: tasks.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) => TaskListTile(task: tasks[index]),
      ),
    );
  }

  Widget _buildBody() {
    return Observer(
      builder: (BuildContext _) {
        return switch(_store.state) {
          TaskIdleState() => _buildEmptyState(),
          TaskLoadingState() => _buildProgressIndicator(),
          TaskFailureState(message: final message) => Text(message ?? ''),
          TaskSuccessState(tasks: final tasks) => _buildList(tasks),
        };
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
