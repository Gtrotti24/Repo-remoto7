import 'package:flutter/material.dart';

class ClassListPacientes extends StatelessWidget {
  const ClassListPacientes({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 216, 147, 241),
        appBar: AppBar(
          title: const Text('Lista de Pacientes'),
          backgroundColor: Colors.purple,
          titleSpacing: 110,
          titleTextStyle: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
