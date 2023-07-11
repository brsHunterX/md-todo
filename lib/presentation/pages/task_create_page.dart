import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:md_todo/domain/blocs/task_bloc.dart';
import 'package:md_todo/domain/dtos/task_create_dto.dart';
import 'package:md_todo/domain/events/task_event.dart';
import 'package:md_todo/domain/states/task_state.dart';

import 'package:md_todo/presentation/widgets/app_snackbar.dart';
import 'package:md_todo/presentation/widgets/app_text_form_field.dart';

class TaskCreatePage extends StatefulWidget {
  const TaskCreatePage({super.key});

  @override
  State<TaskCreatePage> createState() => _TaskCreatePageState();
}

class _TaskCreatePageState extends State<TaskCreatePage> {
  final TaskBloc _bloc = GetIt.instance<TaskBloc>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  void _stateListen(BuildContext context, TaskState state) {
    if (state is TaskSuccessState) {
      ScaffoldMessenger.of(context).showSnackBar(
        AppSnackBar(content: Text(state.message ?? '')),
      );
      Navigator.of(context).pop();
    }
    
    if (state is TaskFailureState) {
      ScaffoldMessenger.of(context).showSnackBar(
        AppSnackBar.error(content: Text(state.message ?? '')),
      );
    }
  }

  void _create() async {
    if (_formKey.currentState!.validate()) {
      _bloc.add(TaskCreateEvent(dto: TaskCreateDTO(
        title: _titleController.text,
        body: _bodyController.text,
      )));
    }
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('New Task'),
    );
  }

  Widget _buildTitleTextField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: AppTextFormField(
        controller: _titleController,
        hintText: 'Title',
        labelText: 'Awesome title',
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }

          return null;
        },
      ),
    );
  }
  
  Widget _buildBodyTextField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: AppTextFormField(
        controller: _bodyController,
        hintText: 'Body',
        labelText: 'Awesome body...',
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }

          return null;
        },
      ),
    );
  }

  Widget _buildCreateButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _create,
        child: const Text('Create task'),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTitleTextField(),
          _buildBodyTextField(),
          _buildCreateButton(),
        ],
      )
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: _buildForm()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocListener(
        bloc: _bloc,
        listener: _stateListen,
        child: _buildBody(),
      ),
    );
  }
}
