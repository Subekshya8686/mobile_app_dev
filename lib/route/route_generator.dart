import 'package:flutter/material.dart';
import 'package:flutter_1/firestore_example/firestore_example.dart';
import 'package:flutter_1/form/form_screen.dart';
import 'package:flutter_1/registration/registration_screen.dart';
import 'package:flutter_1/splash/splash_screen.dart';
import 'package:flutter_1/login/login_screen.dart';
import 'package:flutter_1/form/form_screen.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final arg = settings.arguments;

    switch (settings.name) {
      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case RegistrationScreen.routeName:
        return MaterialPageRoute(builder: (_) => const RegistrationScreen());

      case FormScreen.routeName:
        return MaterialPageRoute(builder: (_) => const FormScreen());

      case FireStoreExample.routeName:
        return MaterialPageRoute(builder: (_) => const FireStoreExample());



      default:
        _onPageNotFound();
    }
  }

  static Route<dynamic> _onPageNotFound() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(body: Text("Page not found")),
    );
  }
}

