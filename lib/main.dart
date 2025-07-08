import 'package:flutter/material.dart';
import 'view/SplashScreenPage.dart'; // Importe o arquivo da splash

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Anotações',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // A primeira tela do nosso app é a SplashScreen
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false, // Remove o banner de "Debug"
    );
  }
}