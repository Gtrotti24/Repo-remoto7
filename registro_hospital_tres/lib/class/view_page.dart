import 'package:flutter/material.dart';

class ViewPage extends StatelessWidget {
  final List<Map<String, String>> entries;

  const ViewPage(this.entries, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Pacientes'),
      ),
      body: ListView.builder(
        itemCount: entries.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
                '${entries[index]['firstName']} ${entries[index]['lastName']}'),
            subtitle: Text('Health Status: ${entries[index]['healthStatus']}'),
          );
        },
      ),
    );
  }
}
