import 'package:dio/dio.dart';
import 'package:md_todo/data/adapters/task_adapter.dart';

import 'package:md_todo/data/datasources/client_datasource.dart';

import 'package:md_todo/domain/dtos/task_create_dto.dart';
import 'package:md_todo/domain/entities/task_entity.dart';

abstract class TaskDataSource {
  Future<List<Task>> all();
  Future<void> store(TaskCreateDTO dto);
  Future<void> remove(String id);
  Future<void> complete(String id);
}

class TaskDataSourceImpl implements TaskDataSource {
  final ClientDataSource client;

  TaskDataSourceImpl(this.client);
  
  @override
  Future<List<Task>> all() async {
    try {
      final Response response = await client.get<Map<String, dynamic>>('/tasks');

      return TaskAdapater.fromListRestAPI(response.data['data'] as List);
    } on Exception catch (e) {
      rethrow;
    }

  }

  @override
  Future<void> store(TaskCreateDTO dto) async {
    try {
      await client.post('/tasks', dto.toRemote());
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<void> remove(String id) async {
    try {
      await client.delete('/tasks/$id');
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<void> complete(String id) async {
    try {
      await client.patch('/tasks/$id/complete', {});
    } on Exception {
      rethrow;
    }
  }
}