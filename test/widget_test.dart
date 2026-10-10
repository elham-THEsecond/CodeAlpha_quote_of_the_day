import 'package:flutter_test/flutter_test.dart';
import 'package:quote_of_the_day/main.dart';

void main() {
  testWidgets('QuoteApp renders New Quote button and handles tap', (WidgetTester tester) async {
    await tester.pumpWidget(const QuoteApp());

    expect(find.text('New Quote'), findsOneWidget);

    await tester.tap(find.text('New Quote'));
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('New Quote'), findsOneWidget);
  });
}
