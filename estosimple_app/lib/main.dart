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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      // Vincula o roteador configurado acima
      routerConfig: _router,
    );
  }
}