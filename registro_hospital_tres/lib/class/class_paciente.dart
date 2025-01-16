class Paciente {
  String id;
  String nombre;
  String estado;

  Paciente({
    required this.id,
    required this.nombre,
    required this.estado,
  });

  // Posibles estados
  static const List<String> estados = ['Normal', 'En recuperación', 'Crítico'];
}
