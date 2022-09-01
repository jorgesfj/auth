import 'package:auth/pages/home_page.dart';
import 'package:auth/pages/login_page.dart';
import 'package:flutter/material.dart';

class FirebaseAuthAppRoutes {

  Map<String, WidgetBuilder> routes = {
    "/login": (BuildContext context) => const LoginPage(),
    "/home": (BuildContext context) => const HomePage()
  };
}