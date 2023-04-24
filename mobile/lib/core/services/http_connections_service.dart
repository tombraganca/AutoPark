abstract class HttpConnectionsService {
  Future get(
    String path, {
    Map<String, String>? headers,
  });
  Future post(String path, Map<String, dynamic> postData,
      {Map<String, String>? headers});
  Future delete(String path, Map<String, dynamic> postData,
      {Map<String, String>? headers});
}
