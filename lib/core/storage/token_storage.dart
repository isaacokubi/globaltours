import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const _tokenKey = 'global_tours_token';
  static const _tenantKey = 'global_tours_tenant';

  Future<void> save({required String token, String? tenant}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    if (tenant != null) await prefs.setString(_tenantKey, tenant);
  }

  Future<String?> token() async => (await SharedPreferences.getInstance()).getString(_tokenKey);
  Future<String?> tenant() async => (await SharedPreferences.getInstance()).getString(_tenantKey);

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_tenantKey);
  }
}
