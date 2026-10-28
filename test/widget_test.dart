import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:campus/main.dart';

void main() {
  testWidgets('CampusClosetApp loads and navigates all 3 onboarding screens', (WidgetTester tester) async {
    // Set standard phone screen dimensions (e.g. Pixel 7 / iPhone: 393 x 852)
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.75;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const CampusClosetApp());
    await tester.pump();

    // Screen 1 checks
    expect(find.text('Campus Closet'), findsOneWidget);
    expect(find.text('Skip'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);

    // Tap Next -> Screen 2
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.text('Trendy finds'), findsOneWidget);
    expect(find.text('Student friendly'), findsOneWidget);
    expect(find.text('Sustainable'), findsOneWidget);
    expect(find.text('Back'), findsOneWidget);

    // Tap Next -> Screen 3
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.text('Sell'), findsOneWidget);
    expect(find.text('Rent'), findsOneWidget);
    expect(find.text('Buy'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);

    // Tap Back -> Screen 2
    await tester.tap(find.text('Back'));
    await tester.pumpAndSettle();

    expect(find.text('Trendy finds'), findsOneWidget);

    // Tap Back -> Screen 1
    await tester.tap(find.text('Back'));
    await tester.pumpAndSettle();

    expect(find.text('Skip'), findsOneWidget);
  });
}
