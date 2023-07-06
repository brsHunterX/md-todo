import 'package:dio/dio.dart';

import 'package:md_todo/data/datasources/client_datasource.dart';
import 'package:md_todo/domain/entities/task_entity.dart';

abstract class TaskDataSource {
  Future<List<Task>> all();
  Future<void> store(Map<String, dynamic> data);
  Future<void> remove(String id);
  Future<void> complete(String id);
}

class TaskDataSourceImpl implements TaskDataSource {
  final ClientDataSource client;

  TaskDataSourceImpl(this.client);
  
  @override
  Future<List<Task>> all() async {
    try {
      final Response response = await client.get('/tasks');

      return (response.data['data'] as List)
        .map((dynamic item) => Task(
          id: item['id'],
          createdAt: item['attributes']['created-at'],
          title: item['attributes']['title'],
          body: item['attributes']['body'],
        ))
        .toList();
    } on Exception {
      rethrow;
    }

  }

  @override
  Future<void> store(Map<String, dynamic> data) async {
    try {
      await client.post('/tasks', data);
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