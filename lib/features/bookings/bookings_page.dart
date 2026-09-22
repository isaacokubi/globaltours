import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/api/api_client.dart';
import '../../core/auth/auth_controller.dart';

class BookingsPage extends StatefulWidget { const BookingsPage({super.key}); @override State<BookingsPage> createState()=>_BookingsPageState(); }
class _BookingsPageState extends State<BookingsPage> {
  late Future<dynamic> future;
  @override void initState(){super.initState(); future=load();}
  Future<dynamic> load() async { final a=context.read<AuthController>(); try{return (await context.read<ApiClient>().get('/bookings',tenantId:a.tenantId)).data;}catch(_){return [];} }
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('My bookings')),body:FutureBuilder(future:future,builder:(c,s){
    if(s.connectionState==ConnectionState.waiting)return const Center(child:CircularProgressIndicator());
    final raw=s.data; final list=raw is List?raw:(raw is Map&&raw['bookings'] is List?raw['bookings']:const []);
    if(list.isEmpty)return const Center(child:Text('No bookings found.'));
    return ListView.builder(itemCount:list.length,itemBuilder:(c,i){
      final b=Map<String,dynamic>.from(list[i]);
      return Card(child:ListTile(title:Text((b['tourName']??b['tour']??'Booking').toString()),subtitle:Text('Status: '+(b['status']??'pending').toString()),trailing:Text((b['totalAmount']??b['amount']??'').toString())));
    });
  }));
}
