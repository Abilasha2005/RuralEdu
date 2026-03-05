import 'package:flutter_test/flutter_test.dart';
import 'package:rurall/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const RuralEduApp());

    // Verify that the dashboard is shown by checking for the "Rural Edu" text
    expect(find.text('Rural Edu'), findsAtLeast(1));
  });
}
