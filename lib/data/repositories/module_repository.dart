import '../../core/api/api_client.dart';
class ModuleRepository {
  final _api = ApiClient.instance;
  Future<dynamic> get(String path,{Map<String,dynamic>? query}) async { final r=await _api.dio.get(path,queryParameters:query); return r.data['data']??r.data; }
  Future<dynamic> post(String path,{Map<String,dynamic>? data}) async { final r=await _api.dio.post(path,data:data); return r.data['data']??r.data; }
  Future<dynamic> put(String path,{Map<String,dynamic>? data}) async { final r=await _api.dio.put(path,data:data); return r.data['data']??r.data; }
  Future<dynamic> delete(String path) async { final r=await _api.dio.delete(path); return r.data['data']??r.data; }
}
