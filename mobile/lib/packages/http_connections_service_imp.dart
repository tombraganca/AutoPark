import 'dart:convert';
import 'package:auto_park/core/config/server_config.dart';
import 'package:auto_park/core/services/http_connections_service.dart';
import 'package:http/http.dart' as http;

class HttpConnectiosServiceImp extends HttpConnectionsService {
  final String token = '';
  final defaultHeaders = {'Content-Type': 'application/json'};
  @override
  Future<http.Response> get(String path, {Map<String, String>? headers}) async {
    try {
      return await http.get(Uri.parse(LOCAL_URL_SERVER + path),
          headers: headers ?? defaultHeaders);
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<http.Response> post(String path, Map<String, dynamic> postData,
      {Map<String, String>? headers}) async {
    try {
      return await http.post(Uri.parse(LOCAL_URL_SERVER + path),
          body: jsonEncode(postData), headers: headers ?? defaultHeaders);
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<http.Response> delete(String path, Map<String, dynamic> postData,
      {Map<String, String>? headers}) async {
    try {
      return await http.delete(Uri.parse(LOCAL_URL_SERVER + path),
          body: jsonEncode(postData), headers: headers ?? defaultHeaders);
    } catch (e) {
      throw e.toString();
    }
  }
}
