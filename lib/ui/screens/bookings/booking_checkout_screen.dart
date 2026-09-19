import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/booking_provider.dart';
import '../../widgets/app_shell.dart';

class BookingCheckoutScreen extends StatefulWidget {
  const BookingCheckoutScreen({super.key, required this.tour});
  final Map<String, dynamic> tour;

  @override
  State<BookingCheckoutScreen> createState() => _BookingCheckoutScreenState();
}

class _BookingCheckoutScreenState extends State<BookingCheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _travelerName = TextEditingController();
  final _phone = TextEditingController();
  final _pickup = TextEditingController();
  final _hotel = TextEditingController();
  final _room = TextEditingController();
  DateTime? _travelDate;
  String _paymentMethod = 'MPESA';
  int _guests = 1;

  @override
  void dispose() {
    _travelerName.dispose();
    _phone.dispose();
    _pickup.dispose();
    _hotel.dispose();
    _room.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate() || _travelDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select a travel date and complete the required fields.')),
      );
      return;
    }

    final provider = context.read<BookingProvider>();
    final ok = await provider.create({
      'tour': widget.tour['_id'] ?? widget.tour['id'],
      'travelDate': _travelDate!.toIso8601String(),
      'numberOfGuests': _guests,
      'travelers': [{'name': _travelerName.text.trim()}],
      'contact': {'phone': _phone.text.trim()},
      'pickupLocation': _pickup.text.trim(),
      'hotelName': _hotel.text.trim(),
      'roomNumber': _room.text.trim(),
      'paymentMethod': _paymentMethod,
      'bookingType': 'individual',
      'specialRequests': <String>[],
    });

    if (!mounted) return;
    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking created. Continue with payment confirmation.')),
      );
      Navigator.pushReplacementNamed(context, '/bookings');
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BookingProvider>();
    final name = widget.tour['name']?.toString() ?? widget.tour['title']?.toString() ?? 'Tour';
    final price = widget.tour['price'] ?? widget.tour['adultPrice'] ?? 0;

    return AppShell(
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text('Book $name', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('Estimated price: KES $price per guest'),
            const SizedBox(height: 20),
            TextFormField(
              controller: _travelerName,
              decoration: const InputDecoration(labelText: 'Lead traveler name'),
              validator: (value) => value == null || value.trim().isEmpty ? 'Name is required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _phone,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'Phone number'),
              validator: (value) => value == null || value.trim().isEmpty ? 'Phone is required' : null,
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(_travelDate == null
                  ? 'Select travel date'
                 : '${_travelDate!.year}-${_travelDate!.month.toString().padLeft(2, '0')}-${_travelDate!.day.toString().padLeft(2, '0')}'),
              trailing: const Icon(Icons.calendar_month),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 730)),
                  initialDate: DateTime.now().add(const Duration(days: 1)),
                );
                if (date != null) setState(() => _travelDate = date);
              },
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<int>(
              initialValue: _guests,
              decoration: const InputDecoration(labelText: 'Number of guests'),
              items: List.generate(
                20,
                (index) => DropdownMenuItem(value: index + 1, child: Text((index + 1).toString())),
              ),
              onChanged: (value) => setState(() => _guests = value ?? 1),
            ),
            const SizedBox(height: 12),
            TextFormField(controller: _pickup, decoration: const InputDecoration(labelText: 'Pickup location')),
            const SizedBox(height: 12),
            TextFormField(controller: _hotel, decoration: const InputDecoration(labelText: 'Hotel / accommodation')),
            const SizedBox(height: 12),
            TextFormField(controller: _room, decoration: const InputDecoration(labelText: 'Room number (optional)')),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _paymentMethod,
              decoration: const InputDecoration(labelText: 'Payment method'),
              items: const [
                DropdownMenuItem(value: 'MPESA', child: Text('M-Pesa')),
                DropdownMenuItem(value: 'CARD', child: Text('Card')),
                DropdownMenuItem(value: 'BANK_TRANSFER', child: Text('Bank transfer')),
              ],
              onChanged: (value) => setState(() => _paymentMethod = value ?? 'MPESA'),
            ),
            if (provider.error != null) ...[
              const SizedBox(height: 16),
              Text(provider.error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
            ],
            const SizedBox(height: 24),
            FilledButton(
              onPressed: provider.submitting ? null : _submit,
              child: provider.submitting
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Create booking'),
            ),
          ],
        ),
      ),
    );
  }
}
