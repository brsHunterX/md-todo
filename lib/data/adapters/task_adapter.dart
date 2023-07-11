import 'dart:convert';

import 'package:md_todo/domain/entities/task_entity.dart';

class TaskAdapater {
  static Task fromRestAPI(Map<String, dynamic> data) {
    return Task(
      id: data['data']['id'],
      createdAt: data['attributes']['created-at'],
      title: data['attributes']['title'],
      body: data['attributes']['body'],
    );
  }

  static List<Task> fromListRestAPI(List<dynamic> list) {

    return list
      .map((data) => Task(
        id: data['id'],
        createdAt: data['attributes']['created-at'],
        title: data['attributes']['title'],
        body: data['attributes']['body'],
      ))
      .toList();
  }
}