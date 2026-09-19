import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../core/routing/app_router.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Scaffold(appBar: AppBar(title: const Text('Sign in')), body: Center(child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 460),
      child: Padding(padding: const EdgeInsets.all(24), child: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: email, decoration: const InputDecoration(labelText: 'Email')),
        const SizedBox(height: 12),
        TextField(controller: password, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
        const SizedBox(height: 20),
        SizedBox(width: double.infinity, child: FilledButton(
          onPressed: auth.loading ? null : () async {
            final ok = await context.read<AuthProvider>().login(email.text.trim(), password.text);
            if (ok && context.mounted) Navigator.pushReplacementNamed(context, AppRouter.home);
          },
          child: auth.loading ? const CircularProgressIndicator() : const Text('Login'),
        )),
      ])),
    )));
  }
}