import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: UserForm(),
    );
  }
}

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  UserFormState createState() => UserFormState();
}

class UserFormState extends State<UserForm> {
  final List<Map<String, String>> _users = [];
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _ageController = TextEditingController();
  int? _editingIndex;

  void _addOrUpdateUser() {
    setState(() {
      if (_editingIndex == null) {
        _users.add({
          'name': _nameController.text,
          'surname': _surnameController.text,
          'age': _ageController.text,
        });
      } else {
        _users[_editingIndex!] = {
          'name': _nameController.text,
          'surname': _surnameController.text,
          'age': _ageController.text,
        };
        _editingIndex = null;
      }
      _nameController.clear();
      _surnameController.clear();
      _ageController.clear();
    });
  }

  void _editUser(int index) {
    setState(() {
      _nameController.text = _users[index]['name']!;
      _surnameController.text = _users[index]['surname']!;
      _ageController.text = _users[index]['age']!;
      _editingIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 180, 20, 220),
        title: const Text('Registro de Usuarios'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Nombres Y Apellidos'),
          ),
          TextField(
            controller: _surnameController,
            decoration: const InputDecoration(labelText: 'Edad'),
          ),
          TextField(
            controller: _ageController,
            decoration: const InputDecoration(labelText: 'Estado de Salud'),
          ),
          ElevatedButton(
            onPressed: _addOrUpdateUser,
            child: Text(_editingIndex == null ? 'Registrar' : 'Actualizar'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _users.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  title: Text(
                      '${_users[index]['name']} ${_users[index]['surname']}'),
                  subtitle: Text('Edad: ${_users[index]['age']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _editUser(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
