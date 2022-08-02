abstract class BaseApiServices {
  Future<dynamic> getSimpleApiResponse(String url);

  Future<dynamic> getApiResponse(String url, path, status);

  Future<dynamic> postApiResponse(String url, dynamic data);

  Future<dynamic> deleteApiResponse(String url, var id);

  Future<dynamic> editApiResponse(String url, dynamic data);
}
