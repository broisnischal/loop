import 'package:flutter_test/flutter_test.dart';
import 'package:loop/app/app.dart';
void main() {
  group('App', () {
    testWidgets('renders Loop', (tester) async {
      await tester.pumpWidget( App());
      expect(find.text('Loop'), findsOneWidget);
    });
  });
}
