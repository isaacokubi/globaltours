import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'router.dart';
import '../core/api/api_client.dart';
import '../core/auth/auth_controller.dart';
import '../core/tenant/tenant_controller.dart';

class GlobalToursApp extends StatelessWidget {
  const GlobalToursApp({super.key});
  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      Provider(create: (_) => ApiClient()),
      ChangeNotifierProvider(create: (_) => AuthController()),
      ChangeNotifierProvider(create: (_) => TenantController()),
    ],
    child: MaterialApp.router(
      title: 'Global Tours',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF15803D)), useMaterial3: true),
      routerConfig: buildRouter(),
    ),
  );
}
