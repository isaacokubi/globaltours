import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Global Tours'), actions: [
      TextButton(onPressed: () => context.push('/tours'), child: const Text('Tours')),
      TextButton(onPressed: () => context.push('/bookings'), child: const Text('Bookings')),
      IconButton(onPressed: () => context.push('/profile'), icon: const Icon(Icons.person_outline)),
    ]),
    body: ListView(padding: const EdgeInsets.all(24), children: [
      Container(padding: const EdgeInsets.all(28), decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), gradient: const LinearGradient(colors: [Color(0xFF15803D), Color(0xFF166534)])), child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Explore Kenya and beyond', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text('Discover tours, manage bookings and pay securely with Global Tours.', style: TextStyle(color: Colors.white70, fontSize: 16)),
      ])),
      const SizedBox(height: 24),
      Card(child: ListTile(leading: const Icon(Icons.explore), title: const Text('Browse tours'), onTap: () => context.push('/tours'))),
      Card(child: ListTile(leading: const Icon(Icons.book_online), title: const Text('My bookings'), onTap: () => context.push('/bookings'))),
    ]),
  );
}
