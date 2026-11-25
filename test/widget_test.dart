import 'package:flutter_test/flutter_test.dart';

import 'package:menus_flutter/main.dart';

void main() {
  testWidgets('App shows welcome page and bottom navigation', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Inicio'), findsWidgets);
    expect(find.text('¡Hola, Bienvenido!'), findsOneWidget);

    await tester.tap(find.text('Peoples').last);
    await tester.pump();
    expect(find.text('Ana García'), findsOneWidget);
  });
}
