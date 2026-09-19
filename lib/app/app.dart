import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_theme.dart';
import '../core/routing/app_router.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/tour_repository.dart';
import '../data/repositories/booking_repository.dart';
import '../data/repositories/finance_repository.dart';
import '../providers/auth_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/tour_provider.dart';
import '../providers/booking_provider.dart';
import '../providers/finance_provider.dart';

class GlobalToursApp extends StatelessWidget {
  const GlobalToursApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      Provider(create: (_) => AuthRepository()),
      Provider(create: (_) => TourRepository()),
      Provider(create: (_) => BookingRepository()),
      Provider(create: (_) => FinanceRepository()),
      ChangeNotifierProvider(create: (c) => AuthProvider(c.read<AuthRepository>())..restoreSession()),
      ChangeNotifierProvider(create: (c) => TourProvider(c.read<TourRepository>())),
      ChangeNotifierProvider(create: (c) => BookingProvider(c.read<BookingRepository>())),
      ChangeNotifierProvider(create: (c) => FinanceProvider(c.read<FinanceRepository>())),
    ],
    child: Consumer<ThemeProvider>(
      builder: (context, theme, child) => MaterialApp(
        title: 'Global Tours',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: theme.mode,
        initialRoute: AppRouter.home,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    ),
  );
}
