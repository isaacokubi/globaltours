import 'package:flutter/material.dart';
import '../../widgets/app_shell.dart';

class TourDetailScreen extends StatelessWidget {
  const TourDetailScreen({super.key, required this.tour});
  final Map<String, dynamic> tour;

  @override
  Widget build(BuildContext context) {
    final title = tour['name']?.toString() ?? tour['title']?.toString() ?? 'Tour';
    final description = tour['description']?.toString() ?? 'Discover this experience with Global Tours.';
    final price = tour['price'] ?? tour['adultPrice'] ?? 0;

    return AppShell(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),
          Text(description),
          const SizedBox(height: 20),
          Text('Price: KES ' + price.toString()),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () => Navigator.pushNamed(
              context,
              '/bookings/checkout',
              arguments: tour,
            ),
            icon: const Icon(Icons.book_online),
            label: const Text('Book this tour'),
          ),
        ],
      ),
    );
  }
}
