import 'package:flutter/material.dart';
import '../../core/routing/app_router.dart';
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Global Tours'), actions: [
      IconButton(onPressed: () => Navigator.pushNamed(context, AppRouter.profile), icon: const Icon(Icons.person_outline)),
    ]),
    drawer: Drawer(child: ListView(children: [
      const DrawerHeader(child: Text('Global Tours')),
      ListTile(title: const Text('Home'), onTap: () => Navigator.pushNamed(context, AppRouter.home)),
      ListTile(title: const Text('Tours'), onTap: () => Navigator.pushNamed(context, AppRouter.tours)),
      ListTile(title: const Text('My Bookings'), onTap: () => Navigator.pushNamed(context, AppRouter.bookings)),
      ListTile(title: const Text('Admin Control Center'), onTap: () => Navigator.pushNamed(context, AppRouter.admin)),
    ])),
    body: child,
  );
}