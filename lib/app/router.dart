import 'package:go_router/go_router.dart';
import '../core/auth/auth_controller.dart';
import '../features/home/home_page.dart';
import '../features/auth/login_page.dart';
import '../features/tours/tours_page.dart';
import '../features/bookings/bookings_page.dart';
import '../features/profile/profile_page.dart';

GoRouter buildRouter() {
  final auth = AuthController();
  return GoRouter(
    initialLocation: '/',
    refreshListenable: auth,
    redirect: (_, state) {
      final protected = state.matchedLocation == '/bookings' || state.matchedLocation == '/profile';
      if (protected && !auth.isAuthenticated) return '/login';
      if (state.matchedLocation == '/login' && auth.isAuthenticated) return '/';
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (_, __) => const HomePage()),
      GoRoute(path: '/login', builder: (_, __) => const LoginPage()),
      GoRoute(path: '/tours', builder: (_, __) => const ToursPage()),
      GoRoute(path: '/bookings', builder: (_, __) => const BookingsPage()),
      GoRoute(path: '/profile', builder: (_, __) => const ProfilePage()),
    ],
  );
}
