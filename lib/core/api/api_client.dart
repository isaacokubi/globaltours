import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../storage/token_storage.dart';

class ApiClient {
  ApiClient._() {
    dio = Dio(BaseOptions(
      baseUrl: dotenv.env['API_BASE_URL'] ?? 'http://localhost:5000/api',
      connectTimeout: Duration(milliseconds: int.tryParse(dotenv.env['CONNECT_TIMEOUT_MS'] ?? '') ?? 15000),
      receiveTimeout: Duration(milliseconds: int.tryParse(dotenv.env['RECEIVE_TIMEOUT_MS'] ?? '') ?? 30000),
      headers: {'Content-Type': 'application/json'},
    ));
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final storage = TokenStorage();
        final token = await storage.token();
        final tenant = await storage.tenant() ?? dotenv.env['TENANT_SLUG'];
        if (token != null && token.isNotEmpty) options.headers['Authorization'] = 'Bearer $token';
        if (tenant != null && tenant.isNotEmpty) options.headers['X-Tenant-Slug'] = tenant;
        handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) await TokenStorage().clear();
        handler.next(error);
      },
    ));
  }
  static final ApiClient instance = ApiClient._();
  late final Dio dio;
}
