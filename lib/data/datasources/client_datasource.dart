import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class ClientDataSource {
  Future<Response> get<T>(String url, {Map<String, dynamic>? queryParameters, Options? options});
  Future<Response> post<T>(String url, dynamic data, {Map<String, dynamic>? queryParameters, Options? options});
  Future<Response> put<T>(String url, dynamic data, {Map<String, dynamic>? queryParameters, Options? options});
  Future<Response> patch<T>(String url, dynamic data, {Map<String, dynamic>? queryParameters, Options? options});
  Future<Response> delete<T>(String url, {Map<String, dynamic>? queryParameters, Options? options});
}

final class ClientDataSourceImpl implements ClientDataSource {
  Future<Dio> _buildClient() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(dotenv.get('APP_TOKEN_KEY'));

    final String baseUrl = Uri(
      scheme: dotenv.get('APP_URI_SCHEME'),
      host: dotenv.get('APP_URI_HOST'),
      port: int.parse(dotenv.get('APP_URI_PORT')),
    ).toString();

    final Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: headers,
      )
    );
  }

  @override
  Future<Response> get<T>(String url, {Map<String, dynamic>? queryParameters, Options? options}) async {
    final Dio client = await _buildClient();
    
    try {
      return await client.get<T>(
        url, queryParameters: queryParameters, options: options
      );
    } catch (e) {
      print(e);
      throw Exception('Failed to make GET request');
    }
  }

  @override
  Future<Response> post<T>(String url, dynamic data, {Map<String, dynamic>? queryParameters, Options? options}) async {
    final Dio client = await _buildClient();
    
    try {
      return await client.post<T>(
        url, data: data, queryParameters: queryParameters, options: options
      );
    } catch (e) {
      throw Exception('Failed to make POST request');
    }
  }

  @override
  Future<Response> put<T>(String url, dynamic data, {Map<String, dynamic>? queryParameters, Options? options}) async {
    final Dio client = await _buildClient();
    
    try {
      return client.put<T>(
        url, data: data, queryParameters: queryParameters, options: options
      );
    } catch (e) {
      throw Exception('Failed to make PUT request');
    }
  }

  @override
  Future<Response> patch<T>(String url, data, {Map<String, dynamic>? queryParameters, Options? options}) async {
    final Dio client = await _buildClient();
    
    try {
      return client.patch<T>(
        url, data: data, queryParameters: queryParameters, options: options
      );
    } catch (e) {
      throw Exception('Failed to make PATCH request');
    }
  }

  @override
  Future<Response> delete<T>(String url, {Map<String, dynamic>? queryParameters, Options? options}) async {
    final Dio client = await _buildClient();
    
    try {
      return client.delete<T>(
        url, queryParameters: queryParameters, options: options
      );
    } catch (e) {
      throw Exception('Failed to make DELETE request');
    }
  }
}
