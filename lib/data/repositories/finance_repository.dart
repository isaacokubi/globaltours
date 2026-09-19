import '../../core/api/api_client.dart';
class FinanceRepository {
  final _api = ApiClient.instance;
  Future<Map<String, dynamic>> reports() async {
    final r = await _api.dio.get('/admin/finance/reports');
    return Map<String, dynamic>.from(r.data['data'] ?? r.data);
  }
  Future<Map<String, dynamic>> reconcile() async {
    final r = await _api.dio.post('/admin/finance/reconciliation/reconcile');
    return Map<String, dynamic>.from(r.data['data'] ?? r.data);
  }
}
