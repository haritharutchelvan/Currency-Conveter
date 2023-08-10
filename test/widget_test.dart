import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:currency11/main.dart'; 

void main() {
  testWidgets('CurrencyConverterApp test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(CurrencyConverterApp());

    // Verify that the initial text is 'Currency Converter'
    expect(find.text('Currency Converter'), findsOneWidget);

    // Verify that the AppBar title is 'Currency Converter'
    expect(find.text('Currency Converter'), findsOneWidget);

    // Verify that the '+' icon is not found in the initial state.
    expect(find.byIcon(Icons.add), findsNothing);

    // Add more widget tests or interaction tests here.
    // For example, if you want to find a widget with specific text,
    // use: expect(find.text('Your Text Here'), findsOneWidget);

    // For example, if you want to tap a widget and trigger a frame,
    // use: await tester.tap(find.widgetWithText(ElevatedButton, 'Your Button Text'));
    //      await tester.pump();

    // In this test case, we are not testing the actual currency conversion,
    // as it requires the loaded exchange rates, which might not be available during testing.
    // Therefore, the conversion-related tests are omitted here.

    // You can add more test scenarios as needed.

  });
}
