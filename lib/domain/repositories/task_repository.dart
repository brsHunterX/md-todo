import 'package:md_todo/data/datasources/task_datasource.dart';

import 'package:md_todo/domain/dtos/task_create_dto.dart';
import 'package:md_todo/domain/entities/task_entity.dart';

abstract interface class TaskRepository {
  Future<List<Task>> list();
  Future<void> create(TaskCreateDTO dto);
  Future<void> complete(String id);
  Future<void> delete(String id);
}

class TaskRepositoryImpl implements TaskRepository {
  
  final TaskDataSource _datasource;

  TaskRepositoryImpl(this._datasource);

  @override
  Future<List<Task>> list() async {
    try {
      return await _datasource.all();
    } on Exception {
      rethrow;
    }
  }
  
  @override
  Future<void> create(TaskCreateDTO dto) async {
    try {
      return await _datasource.store(dto);
    } on Exception {
      rethrow;
    }
  }
  
  @override
  Future<void> delete(String id) async {
    try {
      return await _datasource.remove(id);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<void> complete(String id) async {
    try {
      return await _datasource.complete(id);
    } on Exception {
      rethrow;
    }
  }
}