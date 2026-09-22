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

<!-- DOCS-AUTO:START -->
## Current repository state

This section is maintained automatically by `scripts/update-documentation.js` and the GitHub Actions documentation workflow.

- **Repository:** Global Tours — multi-tenant tours & travel SaaS
- **Branch:** `main`
- **Current commit:** `1932fb8ecff5767f71704ebaa1b8ee17bc0feb63`
- **Short commit:** `1932fb8`
- **Documentation snapshot date (UTC):** 2026-09-22
- **Server package:** `hussein-mboya-tours-server@1.0.0`
- **Client package:** `client@0.0.0`
- **Server verification commands:** `npm run check:all`, `npm test`, `npm run test:security`, `npm run test:tour-domain`
- **Client verification commands:** `npm run lint`, `npm run build`
- **Production contract:** `npm run check:production`
- **Release rule:** production certification requires current deployment/provider evidence; local or CI source checks alone do not certify live production.

### Documentation automation

Every push to `main` runs the documentation workflow. It refreshes this generated repository-state section and commits documentation-only changes when the generated content changes. Manual edits outside the generated markers are preserved.

<!-- DOCS-AUTO:END -->
