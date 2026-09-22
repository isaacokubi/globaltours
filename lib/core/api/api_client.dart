import 'package:dio/dio.dart';

class ApiClient {
  late final Dio dio;
  String? _token;

  ApiClient() {
    const base = String.fromEnvironment('API_URL', defaultValue: 'http://localhost:5000/api');
    dio = Dio(BaseOptions(
      baseUrl: base,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': 'application/json'},
    ));
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (_token != null && _token!.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $_token';
        }
        handler.next(options);
      },
    ));
  }

  void setToken(String? value) => _token = value;

  Future<Response<dynamic>> get(String path, {String? tenantId, String? tenantSlug}) =>
      dio.get(path, options: Options(headers: _headers(tenantId, tenantSlug)));

  Future<Response<dynamic>> post(String path, {dynamic data, String? tenantId, String? tenantSlug}) =>
      dio.post(path, data: data, options: Options(headers: _headers(tenantId, tenantSlug)));

  Map<String, String> _headers(String? id, String? slug) => {
    if (id != null && id.isNotEmpty) 'X-Tenant-ID': id,
    if (slug != null && slug.isNotEmpty) 'X-Tenant-Slug': slug,
  };
}
