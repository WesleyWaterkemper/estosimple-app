import 'package:estosimple_app/models/product.dart';
import 'package:estosimple_app/ui/screens/product_form.dart';
import 'package:estosimple_app/ui/screens/product_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'services/products_service.dart';
import 'providers/products_provider.dart';

void main() {
  runApp(
    // 1. Envolvemos o App no ChangeNotifierProvider
    ChangeNotifierProvider(
      create: (context) => ProductsProvider(ProductsService()),
      child: const MyApp(),
    ),
  );
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    // Rota da Listagem (Read/Delete)
    GoRoute(
      path: '/',
      builder: (context, state) => const ProductsList(),
    ),
    // Rota do Formulário (Create/Update)
    GoRoute(
      path: '/form',
      builder: (context, state) {
        // Se houver um objeto no 'extra', o formulário entende como Edição
        final product = state.extra as Product?;
        return ProductForm(product: product);
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Esto-Simple',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF009688),
          primary: const Color(0xFF00796B),
          secondary: const Color(0xFF1D3557),
          surface: const Color(0xFFF8F9FA),
          error: const Color(0xFFE63946),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF00796B),
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00796B),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF1D3557),
          foregroundColor: Colors.white,
          elevation: 4,
        ),
      ),
      // Vincula o roteador configurado acima
      routerConfig: _router,
    );
  }
}