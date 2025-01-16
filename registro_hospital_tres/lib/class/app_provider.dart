import 'package:flutter/foundation.dart';
import 'package:registro_hospital_tres/class/class_doctor.dart';
import 'package:registro_hospital_tres/class/class_paciente.dart';

class AppProvider extends ChangeNotifier {
  final List<Doctor> _doctores = [];
  final List<Paciente> _pacientes = [];

  List<Doctor> get doctores => _doctores;
  List<Paciente> get pacientes => _pacientes;

  void addDoctor(Doctor doctor) {
    _doctores.add(doctor);
    notifyListeners();
  }

  void addPaciente(Paciente paciente) {
    _pacientes.add(paciente);
    notifyListeners();
  }

  void updatePacienteEstado(String pacienteId, String nuevoEstado) {
    for (int i = 0; i < _pacientes.length; i++) {
      if (_pacientes[i].id == pacienteId) {
        _pacientes[i] = Paciente(
          id: _pacientes[i].id,
          nombre: _pacientes[i].nombre,
          estado: nuevoEstado,
        );
        notifyListeners();
        break;
      }
    }
  }
}
