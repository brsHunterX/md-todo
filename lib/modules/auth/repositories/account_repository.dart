import 'package:dio/dio.dart';

import 'package:md_todo/modules/auth/models/account.dart';
import 'package:md_todo/shared/helpers/client_helper.dart';

class AccountRepository {
  Future<Account> me() async {
    final Dio client = await ClientHelper.buildClient();

    try {
      final Response response = await client.get('/me');

      return Account.fromJsonApi(response);
    } on Exception {
      rethrow;
    }
  }
}