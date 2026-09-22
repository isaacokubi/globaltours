import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/api/api_client.dart';
import '../../core/auth/auth_controller.dart';

class ToursPage extends StatefulWidget { const ToursPage({super.key}); @override State<ToursPage> createState()=>_ToursPageState(); }
class _ToursPageState extends State<ToursPage> {
  late Future<dynamic> future;
  @override void initState(){super.initState(); future=load();}
  Future<dynamic> load() async { final a=context.read<AuthController>(); try{return (await context.read<ApiClient>().get('/tours',tenantId:a.tenantId)).data;}catch(_){return [];} }
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Tours')),body:FutureBuilder(future:future,builder:(c,s){
    if(s.connectionState==ConnectionState.waiting)return const Center(child:CircularProgressIndicator());
    final raw=s.data; final list=raw is List?raw:(raw is Map&&raw['tours'] is List?raw['tours']:const []);
    if(list.isEmpty)return const Center(child:Text('No tours available yet.'));
    return ListView.builder(itemCount:list.length,itemBuilder:(c,i){
      final t=Map<String,dynamic>.from(list[i]);
      return Card(margin:const EdgeInsets.all(8),child:ListTile(title:Text((t['name']??t['title']??'Tour').toString()),subtitle:Text((t['description']??'').toString()),trailing:Text((t['price']??'').toString())));
    });
  }));
}
