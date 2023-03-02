import 'package:md_todo/modules/auth/models/account.dart';
import 'package:md_todo/shared/api/models/json_api_item.dart';

class Task {
  final String id;
  final String createdAt;
  final String title;
  final String body;
  // final Account account;
  final String? completedAt;

  Task({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.body,
    // required this.account,
    this.completedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json['id'],
    createdAt: json['created_at'],
    title: json['title'],
    body: json['body'],
    // account: json['account'],
    completedAt: json['completed_at'],
  );

  factory Task.fromJsonApiItem(JsonApiItem item) => Task.fromJson({
    'id': item.id,
    'created_at': item.attributes['created-at'],
    'title': item.attributes['title'],
    'body': item.attributes['body'],
    // 'account': Account.fromResponse(response.data['data']['attributes']['account']),
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'created_at': createdAt,
    'title': title,
    'body': body,
    'completed_at': completedAt,
  };
}