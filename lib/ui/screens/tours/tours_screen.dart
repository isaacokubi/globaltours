import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/tour_provider.dart';
import '../../../core/routing/app_router.dart';
import '../../widgets/app_shell.dart';
class ToursScreen extends StatefulWidget { const ToursScreen({super.key}); @override State<ToursScreen> createState() => _ToursScreenState(); }
class _ToursScreenState extends State<ToursScreen> {
 @override void initState(){super.initState(); WidgetsBinding.instance.addPostFrameCallback((_)=>context.read<TourProvider>().load());}
 @override Widget build(BuildContext context){final p=context.watch<TourProvider>(); return AppShell(child:p.loading?const Center(child:CircularProgressIndicator()):RefreshIndicator(onRefresh:p.load,child:ListView.builder(padding:const EdgeInsets.all(16),itemCount:p.tours.length,itemBuilder:(_,i){final t=p.tours[i];return Card(child:ListTile(title:Text(t['name']?.toString()??t['title']?.toString()??'Tour'),subtitle:Text('KES ${t['price']??t['adultPrice']??0}'),onTap:()=>Navigator.pushNamed(context,AppRouter.tour,arguments:t)));})));}}
