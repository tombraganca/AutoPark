abstract class HttpConnectionsService {
  String token = '';

  void setToken(String token);

  String getToken() {
    return token;
  }

  void setTokenDefaultHeaders(String token);

  Future get(
    String path, {
    Map<String, String>? headers,
  });
  Future post(String path, Map<String, dynamic> postData,
      {Map<String, String>? headers});
  Future put(String path, Map<String, dynamic> postData,
      {Map<String, String>? headers});
  Future delete(String path, Map<String, dynamic> postData,
      {Map<String, String>? headers});
}
