import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:utm_pawsitive/main.dart';

void main() {
  testWidgets('splash, login, home, and profile flow renders', (tester) async {
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

    await tester.tap(find.byTooltip('Profile'));
    await tester.pumpAndSettle();

    expect(find.text('My Profile'), findsOneWidget);
    expect(find.text('Nurul Ain binti Razali'), findsWidgets);
    expect(find.text('3'), findsOneWidget);
    expect(find.text('Verified'), findsOneWidget);
    expect(find.text('EMAIL'), findsOneWidget);
    expect(find.text('MATRIC / STAFF ID'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('My Reports'), 220);
    await tester.pumpAndSettle();

    expect(find.text('My Reports'), findsOneWidget);
    expect(find.text('Milo'), findsOneWidget);

    await tester.tap(find.text('Activity'));
    await tester.pumpAndSettle();

    expect(
      find.text('You reported Milo at N28 Engineering Block.'),
      findsOneWidget,
    );
    expect(find.text('Your report for Shadow was verified.'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('Sign Out'), 220);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(OutlinedButton, 'Sign Out'));
    await tester.pumpAndSettle();

    expect(find.text('Login'), findsWidgets);
    expect(find.text('Welcome back'), findsOneWidget);
  });
}
