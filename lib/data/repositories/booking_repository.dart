import '../../core/api/api_client.dart';

class BookingRepository {
  final _api = ApiClient.instance;

  Future<List<Map<String, dynamic>>> myBookings() async {
    final response = await _api.dio.get('/bookings/my-bookings');
    final raw = response.data['data'] ?? response.data;
    final list = raw is List ? raw : (raw is Map ? raw['bookings'] ?? [] : []);
    return List<Map<String, dynamic>>.from(
      (list as List).map((item) => Map<String, dynamic>.from(item)),
    );
  }

  Future<Map<String, dynamic>> create(Map<String, dynamic> payload) async {
    final response = await _api.dio.post('/bookings', data: payload);
    return Map<String, dynamic>.from(response.data['data'] ?? response.data);
  }

  Future<void> cancel(String id) async {
    await _api.dio.put('/bookings/cancel/$id');
  }
}
