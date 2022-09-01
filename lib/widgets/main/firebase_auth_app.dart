import 'package:flutter/material.dart';

import '../../firebase_auth_app_routes.dart';
import '../../pages/splash_page.dart';

class FirebaseAuthApp extends StatefulWidget {
  const FirebaseAuthApp({Key? key}) : super(key: key);

  @override
  State<FirebaseAuthApp> createState() => _FirebaseAuthAppState();
}

class _FirebaseAuthAppState extends State<FirebaseAuthApp> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:const SplashPage(),
      routes: FirebaseAuthAppRoutes().routes,
    );
    
  }
}