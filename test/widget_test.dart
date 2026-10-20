import 'package:client_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Patgolito app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const PatgolitoApp());

    // Verify that the app root is rendered.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
