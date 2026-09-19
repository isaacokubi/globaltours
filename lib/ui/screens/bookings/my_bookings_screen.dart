import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/booking_provider.dart';
import '../../widgets/app_shell.dart';
class MyBookingsScreen extends StatefulWidget { const MyBookingsScreen({super.key}); @override State<MyBookingsScreen> createState()=>_MyBookingsScreenState(); }
class _MyBookingsScreenState extends State<MyBookingsScreen>{@override void initState(){super.initState();WidgetsBinding.instance.addPostFrameCallback((_)=>context.read<BookingProvider>().load());}
 @override Widget build(BuildContext context){final p=context.watch<BookingProvider>();return AppShell(child:p.loading?const Center(child:CircularProgressIndicator()):RefreshIndicator(onRefresh:p.load,child:ListView.builder(padding:const EdgeInsets.all(16),itemCount:p.bookings.length,itemBuilder:(_,i){final b=p.bookings[i];return Card(child:ListTile(title:Text('Booking ${(b['bookingNumber']??b['_id']??'')}'),subtitle:Text('Status: ${(b['status']??'pending')}')));})));}}
