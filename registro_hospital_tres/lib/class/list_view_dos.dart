import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: UserFormDos(),
    );
  }
}

class UserFormDos extends StatefulWidget {
  const UserFormDos({super.key});
  @override
  UserFormState createState() => UserFormState();
}

class UserFormState extends State<UserFormDos> {
  final List<Map<String, String>> _users = [];
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _ageController = TextEditingController();
  int? _editingIndex;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final String? usersString = prefs.getString('users');
    if (usersString != null) {
      final List<dynamic> usersList = jsonDecode(usersString);
      setState(() {
        _users.addAll(usersList.map((user) => Map<String, String>.from(user)));
      });
    }
  }

  Future<void> _saveUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final String usersString = jsonEncode(_users);
    await prefs.setString('users', usersString);
  }

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
      _saveUsers();
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
        title: const Text('Registros'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration:
                  const InputDecoration(labelText: 'Nombre y Apellidos'),
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
            SizedBox(
              height: 400,
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
      ),
    );
  }
}
