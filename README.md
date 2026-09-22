# Global Tours Flutter

Native Flutter client for the Global Tours multi-tenant tours and travel platform.

Architecture:
- Flutter is the mobile/web/desktop presentation layer.
- The existing Node.js + Express + MongoDB service remains the authoritative backend.
- Authentication uses the existing API.
- Tenant isolation is preserved by sending the authenticated tenant ID or public tenant slug.
- Tours and bookings are loaded from the existing backend endpoints.

Local development:
flutter pub get
flutter run --dart-define=API_URL=http://localhost:5000/api

Production:
flutter build web --release --dart-define=API_URL=https://YOUR-API/api
