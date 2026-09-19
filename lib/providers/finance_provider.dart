import 'package:flutter/material.dart';
import '../data/repositories/finance_repository.dart';
class FinanceProvider extends ChangeNotifier {
  FinanceProvider(this.repository);
  final FinanceRepository repository;
  Map<String, dynamic> report = {};
  bool loading = false;
  String? message;
  Future<void> load() async {
    loading = true; notifyListeners();
    try { report = await repository.reports(); } catch (e) { message = e.toString(); }
    loading = false; notifyListeners();
  }
  Future<void> reconcile() async {
    try {
      final result = await repository.reconcile();
      message = result['message']?.toString() ?? 'Reconciliation completed';
      await load();
    } catch (e) { message = e.toString(); notifyListeners(); }
  }
}
