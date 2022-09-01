import 'package:flutter/material.dart';

import '../util/firebase_auth_app_navigator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            FirebaseAuthAppNavigator.goToLogin(context);
          }, icon:const  Icon(Icons.arrow_back))
        ],
      ),
      body: Container(
      color: Colors.red,
    ),
    );
  }
}