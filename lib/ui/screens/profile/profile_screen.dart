import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../widgets/app_shell.dart';
class ProfileScreen extends StatelessWidget { const ProfileScreen({super.key});
 @override Widget build(BuildContext context){final auth=context.watch<AuthProvider>();return AppShell(child:Padding(padding:const EdgeInsets.all(20),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('Profile',style:Theme.of(context).textTheme.headlineSmall),const SizedBox(height:16),Text('Name: '+(auth.user?['name']??auth.user?['firstName']??'Guest').toString()),Text('Email: '+(auth.user?['email']??'Not signed in').toString()),const SizedBox(height:20),FilledButton(onPressed:()async{await context.read<AuthProvider>().logout();if(context.mounted)Navigator.pop(context);},child:const Text('Sign out'))])));}
}
