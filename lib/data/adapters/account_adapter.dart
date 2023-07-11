import 'package:md_todo/domain/entities/account_entity.dart';

class AccountAdapater {
  static Account fromRestAPI(Map<String, dynamic> data) {
    return Account(
      id: data['data']['id'],
      firstName: data['data']['attributes']['first-name'],
      lastName: data['data']['attributes']['last-name'],
      email: data['data']['attributes']['email'],
      avatar: data['data']['attributes']['avatar'],
    );
  }
}