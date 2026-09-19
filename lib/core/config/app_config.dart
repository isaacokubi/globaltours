import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  const AppConfig._();

  static String get apiBaseUrl =>
      (dotenv.env['API_BASE_URL'] ?? 'http://localhost:5000/api').trim();

  static String get tenantSlug =>
      (dotenv.env['TENANT_SLUG'] ?? '').trim();

  static int get connectTimeoutMs =>
      int.tryParse(dotenv.env['CONNECT_TIMEOUT_MS'] ?? '') ?? 15000;

  static int get receiveTimeoutMs =>
      int.tryParse(dotenv.env['RECEIVE_TIMEOUT_MS'] ?? '') ?? 30000;
}
