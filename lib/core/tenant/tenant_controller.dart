import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TenantController extends ChangeNotifier {
  String? slug;
  String? name;
  Future<void> select(String value, {String? tenantName}) async {
    slug = value; name = tenantName;
    final p = await SharedPreferences.getInstance();
    await p.setString('tenant_slug', value);
    if (tenantName != null) await p.setString('tenant_name', tenantName);
    notifyListeners();
  }
  Future<void> restore() async {
    final p = await SharedPreferences.getInstance();
    slug = p.getString('tenant_slug');
    name = p.getString('tenant_name');
    notifyListeners();
  }
}
