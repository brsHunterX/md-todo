import 'package:dio/dio.dart';

import 'package:md_todo/shared/helpers/client_helper.dart';

import 'package:md_todo/modules/tasks/models/task.dart';
import 'package:md_todo/shared/api/models/json_api_item.dart';

class TaskRepository {
  Future<List<Task>> list() async {
    final Dio client = await ClientHelper.buildClient();
    
    try {
      final Response response = await client.get('/tasks');

      return (response.data['data'] as List)
        .map((dynamic item) => Task.fromJsonApiItem(JsonApiItem.fromMap(item)))
        .toList();
    } on Exception {
      rethrow;
    }
  }

  Future<Task> create(Map<String, dynamic> data) async {
    final Dio client = await ClientHelper.buildClient();
    
    try {
      final Response response = await client.post('/tasks', data: data);

      return Task.fromJsonApiItem(JsonApiItem.fromMap(response.data['data']));
    } on Exception {
      rethrow;
    }
  }
  
  Future<void> complete(String id) async {
    final Dio client = await ClientHelper.buildClient();
    
    try {
      await client.patch('/tasks/$id/complete', data: {});
    } on Exception {
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    final Dio client = await ClientHelper.buildClient();
    
    try {
      await client.delete('/tasks/$id');
    } on Exception {
      rethrow;
    }
  }
}