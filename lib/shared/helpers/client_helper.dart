import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientHelper {
  static Uri buildUri() {
    return Uri(
      scheme: dotenv.get('APP_URI_SCHEME'),
      host: dotenv.get('APP_URI_HOST'),
      port: int.parse(dotenv.get('APP_URI_PORT')),
      // path: dotenv.get('APP_URI_PATH'),
    );
  }

  static Future<Map<String, String>> buildHeaders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(dotenv.get('APP_TOKEN_KEY'));
    
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  static Future<Dio> buildClient() async {
    return Dio(
      BaseOptions(
        baseUrl: buildUri().toString(),
        headers: await buildHeaders(),
      )
    );
  }
}