import 'package:flutter/material.dart';
import '../core/api/api_error.dart';
import '../data/repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider(this.repository);

  final AuthRepository repository;
  Map<String, dynamic>? user;
  bool loading = false;
  String? error;

  bool get isAuthenticated => user != null;

  Future<void> restoreSession() async {
    try {
      user = await repository.me();
    } catch (_) {
      user = null;
    }
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      user = await repository.login(email, password);
      return true;
    } catch (e) {
      error = ApiError.from(e).message;
      user = null;
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await repository.logout();
    user = null;
    notifyListeners();
  }
}
