import 'dart:convert';
import 'dart:developer';
import 'package:auto_park/core/config/server_config.dart';
import 'package:auto_park/core/services/http_connections_service.dart';
import 'package:http/http.dart' as http;

class HttpConnectiosServiceImp extends HttpConnectionsService {
  Map<String, String> defaultHeaders = {};

  HttpConnectiosServiceImp() {
    defaultHeaders = {
      "Content-Type": "application/json; charset=UTF-8 ",
      "Authorization": "Bearer ${super.token}"
    };
  }
  @override
  String getToken() {
    return super.token;
  }

  @override
  void setTokenDefaultHeaders(String token) {
    defaultHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Bearer ${super.token}"
    };
  }

  @override
  void setToken(String token) => super.token = token;

  @override
  Future<http.Response> get(String path, {Map<String, String>? headers}) async {
    try {
      log(name: 'GET', path);
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
      log(name: 'POST', '$path  \n  $postData');
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

  @override
  Future put(String path, Map<String, dynamic> postData,
      {Map<String, String>? headers}) async {
    try {
      log(name: 'PUT', '$path  \n  $postData');
      return await http.put(Uri.parse(LOCAL_URL_SERVER + path),
          body: jsonEncode(postData), headers: headers ?? defaultHeaders);
    } catch (e) {
      throw e.toString();
    }
  }
}
