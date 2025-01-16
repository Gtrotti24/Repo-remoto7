import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registro_hospital_tres/class/register_main.dart';
import 'package:registro_hospital_tres/class/wave.dart';
import 'class/app_provider.dart';
import 'class/authentication_screen.dart';
import 'class/authentication_screen_dos.dart';
import 'class/class_update_estado_screen.dart';
import 'class/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: const MainApp(),
    ),
  );
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.purple,
        titleSpacing: 110,
        titleTextStyle: const TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Wave(),
              const SizedBox(height: 20),

              ElevatedButton(
                child: const Text(' REGISTRARSE'),
                onPressed: () {
                  Navigator.pushNamed(context, "/registerDoctor");

                  // Lógica para registrar paciente
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('INGRESAR COMO DOCTOR'),
                onPressed: () {
                  Navigator.pushNamed(context, '/registerPaciente');
                },
              ),
              const SizedBox(height: 20), // Espacio entre los botones
              ElevatedButton(
                child: const Text('LISTA DE PACIENTES'),
                onPressed: () {
                  Navigator.pushNamed(context, "/registerPaciente");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hospital App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/registerDoctor': (context) => const AuthenticationScreen(),
        '/registerPaciente': (context) => const AuthenticationScreenDos(),
        '/updateEstado': (context) => const UpdateEstadoScreen(),
        '/homeScreen': (context) => HomeScreen(),
        '/listado': (context) => const MyAppi(),
      },
    );
  }
}
