import '../../core/api/api_client.dart';
class TourRepository {
  final _api = ApiClient.instance;
  Future<List<Map<String, dynamic>>> getTours() async {
    final r = await _api.dio.get('/tours');
    final raw = r.data['data'] ?? r.data;
    final list = raw is List ? raw : (raw['tours'] ?? []);
    return List<Map<String, dynamic>>.from(list.map((e) => Map<String, dynamic>.from(e)));
  }
  Future<Map<String, dynamic>> getTour(String id) async {
    final r = await _api.dio.get('/tours/$id');
    return Map<String, dynamic>.from(r.data['data'] ?? r.data);
  }
}
