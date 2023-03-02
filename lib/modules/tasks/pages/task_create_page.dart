import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:md_todo/app/routes.dart';

import 'package:md_todo/modules/tasks/stores/task.store.dart';

class TaskCreatePage extends StatefulWidget {
  const TaskCreatePage({super.key});

  @override
  State<TaskCreatePage> createState() => _TaskCreatePageState();
}

class _TaskCreatePageState extends State<TaskCreatePage> {
  final TaskStore _store = TaskStore();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  void _create() async {
    final Map<String, dynamic> data = {
      'title': _titleController.text,
      'body': _bodyController.text,
    };

    if (_formKey.currentState!.validate()) {
      try {
        _store.create(data).then((value) {
          Navigator.of(context).pushNamed(AppRoutes.APP_NAVIGATION);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${data['title']} created successfully!'),
              backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          );
        });
      } on DioError catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.response!.data['message']),
            backgroundColor: Theme.of(context).colorScheme.onErrorContainer,
          ),
        );
      }
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
      child: TextFormField(
        controller: _titleController,
        decoration: const InputDecoration(
          labelText: 'Title',
          border: OutlineInputBorder(),
          hintText: 'Awesome title'
        ),
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
      child: TextFormField(
        controller: _bodyController,
        decoration: const InputDecoration(
          labelText: 'Body',
          border: OutlineInputBorder(),
          hintText: 'Awesome task....'
        ),
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
      body: _buildBody(),
    );
  }
}
