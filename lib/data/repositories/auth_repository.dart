import '../../core/api/api_client.dart';
import '../../core/storage/token_storage.dart';
class AuthRepository {
  final _api = ApiClient.instance;
  Future<Map<String, dynamic>> login(String email, String password) async {
    final r = await _api.dio.post('/auth/login', data: {'email': email, 'password': password});
    final data = Map<String, dynamic>.from(r.data['data'] ?? r.data);
    final token = data['token'] ?? r.data['token'];
    if (token is String) await TokenStorage().save(token: token);
    return data;
  }
  Future<Map<String, dynamic>> me() async {
    final r = await _api.dio.get('/auth/me');
    return Map<String, dynamic>.from(r.data['data'] ?? r.data);
  }
  Future<void> logout() => TokenStorage().clear();
}
