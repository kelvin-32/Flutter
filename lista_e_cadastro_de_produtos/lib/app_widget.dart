import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'views/product_search_screen.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Produtos',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.defaultTheme,
      home: const ProductSearchScreen(),
    );
  }
}
