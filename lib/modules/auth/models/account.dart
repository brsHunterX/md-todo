import 'package:dio/dio.dart';

class Account {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? avatar;

  Account({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.avatar,
  });

  String get fullName => '$firstName $lastName';
  String get shortName => '${firstName[0]}${lastName[0]}'.toUpperCase();
  bool get hasAvatar => avatar != null && avatar!.isNotEmpty;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
    id: json['id'],
    firstName: json['first_name'],
    lastName: json['last_name'],
    email: json['email'],
    avatar: json['avatar'],
  );

  factory Account.fromJsonApi(Response response) => Account.fromJson({
    'id': response.data['data']['id'],
    'first_name': response.data['data']['attributes']['first-name'],
    'last_name': response.data['data']['attributes']['last-name'],
    'email': response.data['data']['attributes']['email'],
    'avatar': response.data['data']['attributes']['avatar'],
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'first_name': firstName,
    'last_name': lastName,
    'email': email,
    'avatar': avatar,
  };
}