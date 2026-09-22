import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../core/auth/auth_controller.dart';

class ProfilePage extends StatelessWidget { const ProfilePage({super.key});
  @override Widget build(BuildContext context){final a=context.watch<AuthController>();return Scaffold(appBar:AppBar(title:const Text('Account')),body:Padding(padding:const EdgeInsets.all(24),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    Text((a.user?['name']??'Guest').toString(),style:const TextStyle(fontSize:24,fontWeight:FontWeight.bold)),
    Text((a.user?['email']??'Not signed in').toString()),const SizedBox(height:24),
    if(a.isAuthenticated) FilledButton(onPressed:()=>a.logout(),child:const Text('Sign out')) else OutlinedButton(onPressed:()=>context.go('/login'),child:const Text('Sign in')),
  ]));}
}
