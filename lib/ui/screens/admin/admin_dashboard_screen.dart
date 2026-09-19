import 'package:flutter/material.dart';
import '../../widgets/app_shell.dart';
import '../../../core/routing/app_router.dart';
class AdminDashboardScreen extends StatelessWidget { const AdminDashboardScreen({super.key});
 @override Widget build(BuildContext context)=>AppShell(child:GridView.count(padding:const EdgeInsets.all(20),crossAxisCount:MediaQuery.sizeOf(context).width>800?4:2,children:[_card(context,'Finance',Icons.account_balance,AppRouter.finance),_card(context,'Bookings',Icons.book_online,AppRouter.bookings),_card(context,'Tours',Icons.travel_explore,AppRouter.tours),_card(context,'Profile',Icons.person,AppRouter.profile)]));
 Widget _card(BuildContext c,String title,IconData icon,String route)=>Card(child:InkWell(onTap:()=>Navigator.pushNamed(c,route),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(icon,size:34),Text(title)])));
}
