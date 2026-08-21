import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth_check.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BookNst',
      debugShowCheckedModeBanner: false,
      home: AuthCheck(),
    );
  }
}

