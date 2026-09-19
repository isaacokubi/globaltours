import 'package:flutter/material.dart';
import '../../ui/screens/home/home_screen.dart';
import '../../ui/screens/auth/login_screen.dart';
import '../../ui/screens/tours/tours_screen.dart';
import '../../ui/screens/tours/tour_detail_screen.dart';
import '../../ui/screens/bookings/my_bookings_screen.dart';
import '../../ui/screens/bookings/booking_checkout_screen.dart';
import '../../ui/screens/admin/admin_dashboard_screen.dart';
import '../../ui/screens/admin/finance_screen.dart';
import '../../ui/screens/profile/profile_screen.dart';

class AppRouter {
  static const home = '/';
  static const login = '/login';
  static const tours = '/tours';
  static const tour = '/tour';
  static const bookings = '/bookings';
  static const bookingCheckout = '/bookings/checkout';
  static const admin = '/admin';
  static const finance = '/admin/finance';
  static const profile = '/profile';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case tours:
        return MaterialPageRoute(builder: (_) => const ToursScreen());
      case tour:
        return MaterialPageRoute(
          builder: (_) => TourDetailScreen(
            tour: settings.arguments as Map<String, dynamic>,
          ),
        );
      case bookings:
        return MaterialPageRoute(builder: (_) => const MyBookingsScreen());
      case bookingCheckout:
        return MaterialPageRoute(
          builder: (_) => BookingCheckoutScreen(
            tour: settings.arguments as Map<String, dynamic>,
          ),
        );
      case admin:
        return MaterialPageRoute(builder: (_) => const AdminDashboardScreen());
      case finance:
        return MaterialPageRoute(builder: (_) => const FinanceScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
