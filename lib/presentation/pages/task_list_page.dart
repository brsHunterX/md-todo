import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:md_todo/domain/blocs/task_bloc.dart';
import 'package:md_todo/domain/events/task_event.dart';
import 'package:md_todo/domain/states/task_state.dart';
import 'package:md_todo/domain/entities/task_entity.dart';

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
  final TaskBloc _bloc = GetIt.instance<TaskBloc>();

  @override
  void initState() {
    super.initState();

    _bloc.add(TaskListEvent());
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

  Widget _buildIdleState(String message) {
    return AppEmptyState.icon(
      icon: Icons.checklist_rounded,
      message: message
    );
  }
  
  Widget _buildFailureState(String message) {
    return AppEmptyState.icon(
      icon: Icons.error_outline_rounded,
      message: message
    );
  }

  Widget _buildList(List<Task> tasks) {
    return RefreshIndicator(
      onRefresh: () => Future.value(null),
      child: ListView.separated(
        itemCount: tasks.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) => TaskListTile(task: tasks[index]),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<TaskBloc, TaskState>(
      bloc: _bloc,
      builder: (BuildContext context, TaskState state) {
        return switch(state) {
          TaskLoadingState() => _buildProgressIndicator(),
          TaskIdleState(message: final message) => _buildIdleState(message ?? ''),
          TaskFailureState(message: final message) => _buildFailureState(message ?? ''),
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
