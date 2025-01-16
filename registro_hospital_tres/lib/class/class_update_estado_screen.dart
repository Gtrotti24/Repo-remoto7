import 'package:flutter/material.dart';
import 'package:registro_hospital_tres/class/wave.dart';

class Paciente {
  final String id;
  final String nombre;
  final String estado;

  Paciente({required this.id, required this.nombre, required this.estado});

  // Método para crear una nueva instancia con un estado actualizado
  Paciente copyWith({String? estado}) {
    return Paciente(
      // ignore: unnecessary_this
      id: this.id,
      // ignore: unnecessary_this
      nombre: this.nombre,
      estado: estado ?? this.estado,
    );
  }

  static const List<String> estados = [
    'Normal',
    'En recuperación',
    'Crítico',
    'En espera'
  ];
}

class UpdateEstadoScreen extends StatefulWidget {
  const UpdateEstadoScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UpdateEstadoScreenState createState() => _UpdateEstadoScreenState();
}

class _UpdateEstadoScreenState extends State<UpdateEstadoScreen> {
  Paciente paciente = Paciente(id: '1', nombre: 'Juan', estado: 'En espera');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 216, 147, 241),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            const Wave(),
            Text('Paciente: ${paciente.nombre}'),
            DropdownButton<String>(
              value: paciente.estado,
              items: Paciente.estados.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    // Crear una nueva instancia del paciente con el nuevo estado
                    paciente = paciente.copyWith(estado: newValue);
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Actualizar Estado'),
              onPressed: () {
                // Lógica para confirmar la actualización del estado
              },
            ),
          ],
        ),
      ),
    );
  }
}
