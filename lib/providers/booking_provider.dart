import 'package:flutter/material.dart';
import '../data/repositories/booking_repository.dart';
class BookingProvider extends ChangeNotifier {
  BookingProvider(this.repository);
  final BookingRepository repository;
  List<Map<String, dynamic>> bookings = [];
  bool loading = false;
  Future<void> load() async {
    loading = true; notifyListeners();
    try { bookings = await repository.myBookings(); } finally { loading = false; notifyListeners(); }
  }
}
