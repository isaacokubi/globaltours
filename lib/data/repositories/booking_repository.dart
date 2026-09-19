import '../../core/api/api_client.dart';
class BookingRepository {
  final _api = ApiClient.instance;
  Future<List<Map<String, dynamic>>> myBookings() async {
    final r = await _api.dio.get('/bookings/my-bookings');
    final raw = r.data['data'] ?? r.data;
    final list = raw is List ? raw : (raw['bookings'] ?? []);
    return List<Map<String, dynamic>>.from(list.map((e) => Map<String, dynamic>.from(e)));
  }
  Future<Map<String, dynamic>> create(Map<String, dynamic> payload) async {
    final r = await _api.dio.post('/bookings', data: payload);
    return Map<String, dynamic>.from(r.data['data'] ?? r.data);
  }
  Future<void> cancel(String id) async { await _api.dio.put('/bookings/cancel/$id'); }
}
