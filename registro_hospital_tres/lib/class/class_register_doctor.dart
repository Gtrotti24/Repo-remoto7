import 'package:flutter/material.dart';

class RegisterDoctorScreen extends StatelessWidget {
  RegisterDoctorScreen({super.key});
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _especialidadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Registro de Doctor')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _especialidadController,
              decoration: const InputDecoration(labelText: 'Especialidad'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Registrar'),
              onPressed: () {
                Navigator.pushNamed(context, '/listView');

                // Lógica para regprstrar doctor
              },
            ),
          ],
        ),
      ),
    );
  }
}
