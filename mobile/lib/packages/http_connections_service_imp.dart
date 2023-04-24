import 'package:auto_park/core/services/http_connections_service.dart';
import 'package:http/http.dart' as http;

class HttpConnectiosServiceImp extends HttpConnectionsService {
  @override
  Future<http.Response> get(String path, {Map<String, String>? headers}) async {
    try {
      return await http.get(Uri.parse(path), headers: headers);
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<http.Response> post(String path, Map<String, dynamic> postData,
      {Map<String, String>? headers}) async {
    try {
      return await http.post(Uri.parse(path), body: postData, headers: headers);
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<http.Response> delete(String path, Map<String, dynamic> postData,
      {Map<String, String>? headers}) async {
    try {
      return await http.delete(Uri.parse(path),
          body: postData, headers: headers);
    } catch (e) {
      throw e.toString();
    }
  }
}
