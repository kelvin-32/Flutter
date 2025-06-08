import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/product_controller.dart';
import 'views/product_search_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ProductController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const customColor = Colors.black; // Preto

    return MaterialApp(
      title: 'Lista e Cadastro de Produtos',
      theme: ThemeData(
        primaryColor: customColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: customColor,
          secondary: customColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: customColor,
          foregroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: customColor,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: customColor,
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: const ProductSearchScreen(),
    );
  }
}
