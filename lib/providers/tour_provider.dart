import 'package:flutter/material.dart';
import '../core/api/api_error.dart';
import '../data/repositories/tour_repository.dart';

class TourProvider extends ChangeNotifier {
  TourProvider(this.repository);

  final TourRepository repository;
  List<Map<String, dynamic>> tours = [];
  bool loading = false;
  String? error;

  Future<void> load() async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      tours = await repository.getTours();
    } catch (e) {
      error = ApiError.from(e).message;
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
