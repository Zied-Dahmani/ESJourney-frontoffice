import 'package:esjourney/presentation/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'routes.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    final Object? args = settings.arguments;

    switch (settings.name) {
      case AppRoutes.signInScreen:
        return MaterialPageRoute(
          builder: (_) => SignInScreen(),
        );

      default:
        return null;
    }
  }
}
