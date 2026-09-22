import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/auth/auth_controller.dart';

class LoginPage extends StatefulWidget { const LoginPage({super.key}); @override State<LoginPage> createState()=>_LoginPageState(); }
class _LoginPageState extends State<LoginPage> {
  final email=TextEditingController(), password=TextEditingController(), tenant=TextEditingController();
  bool loading=false;
  Future<void> submit() async {
    setState(()=>loading=true);
    final ok=await context.read<AuthController>().login(email.text.trim(), password.text, tenantSlug: tenant.text.trim().isEmpty?null:tenant.text.trim());
    if (!mounted) return;
    setState(()=>loading=false);
    if(ok) context.go('/'); else ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login failed. Check your details and tenant.')));
  }
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Sign in')),body:Center(child:ConstrainedBox(constraints:const BoxConstraints(maxWidth:480),child:Card(margin:const EdgeInsets.all(24),child:Padding(padding:const EdgeInsets.all(24),child:Column(mainAxisSize:MainAxisSize.min,children:[
    const Text('Global Tours',style:TextStyle(fontSize:28,fontWeight:FontWeight.bold)),const SizedBox(height:24),
    TextField(controller:tenant,decoration:const InputDecoration(labelText:'Tenant slug (optional)')),const SizedBox(height:12),
    TextField(controller:email,decoration:const InputDecoration(labelText:'Email')),const SizedBox(height:12),
    TextField(controller:password,obscureText:true,decoration:const InputDecoration(labelText:'Password')),const SizedBox(height:20),
    SizedBox(width:double.infinity,child:FilledButton(onPressed:loading?null:submit,child:loading?const CircularProgressIndicator():const Text('Sign in')))
  ]))))));
}
