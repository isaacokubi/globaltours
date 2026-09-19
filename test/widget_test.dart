import 'package:flutter_test/flutter_test.dart';
import 'package:globaltours/app/app.dart';

void main() {
  testWidgets('Global Tours app renders', (tester) async {
    await tester.pumpWidget(const GlobalToursApp());
    await tester.pump();
    expect(find.text('Global Tours'), findsWidgets);
  });
}
