import 'package:flutter_test/flutter_test.dart';
import 'package:kerygma_reader/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const KerygmaApp());
    expect(find.text('Kerygma Reader'), findsOneWidget);
  });
}
