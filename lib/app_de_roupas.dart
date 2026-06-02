import 'package:app_de_roupa/app_de_roupas_index.dart';
import 'package:flutter/material.dart';

class AppDeRoupas extends StatelessWidget {
  const AppDeRoupas({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Color.fromARGB(255, 135, 92, 255))),
      home: AppDeRoupasIndex()
    );
  }
}