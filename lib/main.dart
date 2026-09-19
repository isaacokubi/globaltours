import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app/app.dart';
import 'core/notifications/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: '.env');
  } catch (_) {
    // CI and fresh clones may not have a local .env yet.
    // ApiClient provides safe development defaults.
  }

  await NotificationService.initialize();
  runApp(const GlobalToursApp());
}
