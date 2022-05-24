import 'package:flutter/material.dart';
import 'package:movarr/src/shared/presentation/home_view/home_view.dart';
import 'package:movarr/src/utils/routes.dart';

void main() {
  runApp(const Movarr());
}

class Movarr extends StatelessWidget {
  const Movarr({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.homeRoute,
      onGenerateRoute: (route) {
        switch (route.name) {
          case AppRoutes.homeRoute:
            return MaterialPageRoute(builder: (context) => const HomeView());
          default:
            return MaterialPageRoute(builder: (context) => const HomeView());
        }
      },
      title: 'Movarr',
    );
  }
}
