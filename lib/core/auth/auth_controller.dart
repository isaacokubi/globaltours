import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../api/api_client.dart';

class AuthController extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  ApiClient? _api;
  Map<String, dynamic>? user;
  String? token;
  String? tenantId;
  bool get isAuthenticated => token != null && token!.isNotEmpty;
  void setApi(ApiClient api) => _api ??= api;

  Future<bool> login(String email, String password, {String? tenantSlug}) async {
    try {
      final r = await _api!.post('/auth/login', data: {'email': email, 'password': password}, tenantSlug: tenantSlug);
      final data = Map<String, dynamic>.from(r.data is Map ? r.data : {});
      final t = data['token'] ?? data['accessToken'];
      if (t == null) return false;
      token = t.toString();
      user = data['user'] is Map ? Map<String, dynamic>.from(data['user']) : null;
      tenantId = user?['tenantId']?.toString();
      await _storage.write(key: 'auth_token', value: token);
      if (tenantId != null) await _storage.write(key: 'tenant_id', value: tenantId);
      notifyListeners();
      return true;
    } catch (_) { return false; }
  }
  Future<void> logout() async { token = null; user = null; tenantId = null; await _storage.deleteAll(); notifyListeners(); }
}
