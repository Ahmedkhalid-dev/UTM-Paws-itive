import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:utm_pawsitive/main.dart';

void main() {
  testWidgets('splash, login, and home flow renders', (tester) async {
    await tester.pumpWidget(const PawsitiveApp());

    expect(find.text('UTM Paws-itive'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);

    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    expect(find.text('Login'), findsWidgets);
    expect(find.text('Create new account'), findsOneWidget);

    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    expect(find.text('Animal Reports'), findsOneWidget);
    expect(find.text('Cat near Library'), findsOneWidget);
    expect(find.text('Report Animal'), findsOneWidget);
  });
}
