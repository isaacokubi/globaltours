import 'package:flutter/material.dart';
import '../core/api/api_error.dart';
import '../data/repositories/booking_repository.dart';

class BookingProvider extends ChangeNotifier {
  BookingProvider(this.repository);

  final BookingRepository repository;
  List<Map<String, dynamic>> bookings = [];
  bool loading = false;
  bool submitting = false;
  String? error;

  Future<void> load() async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      bookings = await repository.myBookings();
    } catch (e) {
      error = ApiError.from(e).message;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<bool> create(Map<String, dynamic> payload) async {
    submitting = true;
    error = null;
    notifyListeners();

    try {
      await repository.create(payload);
      await load();
      return true;
    } catch (e) {
      error = ApiError.from(e).message;
      return false;
    } finally {
      submitting = false;
      notifyListeners();
    }
  }

  Future<bool> cancel(String id) async {
    try {
      await repository.cancel(id);
      await load();
      return true;
    } catch (e) {
      error = ApiError.from(e).message;
      notifyListeners();
      return false;
    }
  }
}
