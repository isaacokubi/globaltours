import 'package:flutter/material.dart';
import '../../widgets/app_shell.dart';
import '../../../core/routing/app_router.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) => AppShell(child: ListView(padding: const EdgeInsets.all(20), children: [
    Text('Explore Africa with Global Tours', style: Theme.of(context).textTheme.headlineMedium),
    const SizedBox(height: 8),
    const Text('Tours, bookings, hospitality, transport and travel operations in one platform.'),
    const SizedBox(height: 24),
    FilledButton(onPressed: () => Navigator.pushNamed(context, AppRouter.tours), child: const Text('Explore Tours')),
    const SizedBox(height: 12),
    OutlinedButton(onPressed: () => Navigator.pushNamed(context, AppRouter.bookings), child: const Text('My Bookings')),
  ]));
}