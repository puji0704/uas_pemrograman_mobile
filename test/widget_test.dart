import 'package:flutter_test/flutter_test.dart';
import 'package:safecontact/main.dart';

void main() {
  testWidgets('App loads smoke test', (WidgetTester tester) async {
    // HAPUS "const" dari MyApp()
    await tester.pumpWidget(const MyApp()); // tanpa const
    await tester.pumpAndSettle();

    // Verify that the app title is shown.
    expect(find.text('SafeContect'), findsOneWidget);
  });
}
