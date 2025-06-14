// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:lista_e_cadastro_de_produtos/app_widget.dart';

void main() {
  testWidgets('AppWidget smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const AppWidget());

    // Verifica se o título da AppBar está presente.
    expect(find.text('Produtos'), findsOneWidget);
  });
}
