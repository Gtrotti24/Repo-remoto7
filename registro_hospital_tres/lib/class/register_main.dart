import 'package:flutter/material.dart';
import 'package:registro_hospital_tres/class/view_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MyAppi extends StatelessWidget {
  const MyAppi({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Map<String, String>> entries = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('entries');
    if (data != null) {
      setState(() {
        entries = List<Map<String, String>>.from(json.decode(data));
      });
    }
  }

  saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('entries', json.encode(entries));
  }

  addEntry(String firstName, String lastName, String healthStatus) {
    setState(() {
      entries.add({
        'firstName': firstName,
        'lastName': lastName,
        'healthStatus': healthStatus
      });
    });
    saveData();
  }

  editEntry(int index, String firstName, String lastName, String healthStatus) {
    setState(() {
      entries[index] = {
        'firstName': firstName,
        'lastName': lastName,
        'healthStatus': healthStatus
      };
    });
    saveData();
  }

  deleteEntry(int index) {
    setState(() {
      entries.removeAt(index);
    });
    saveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro Pacientes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.view_list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ViewPage(entries)),
              );
            },
          ),
          ElevatedButton(
            child: const Text('HOME'),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/',
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: entries.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
                '${entries[index]['firstName']} ${entries[index]['lastName']}'),
            subtitle: Text('Health Status: ${entries[index]['healthStatus']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    showEditDialog(index);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    deleteEntry(index);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showAddDialog();
        },
      ),
    );
  }

  showAddDialog() {
    String firstName = '';
    String lastName = '';
    String healthStatus = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Datos'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Nombre'),
                onChanged: (value) {
                  firstName = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Apellido'),
                onChanged: (value) {
                  lastName = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Estado'),
                onChanged: (value) {
                  healthStatus = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                if (firstName.isNotEmpty &&
                    lastName.isNotEmpty &&
                    healthStatus.isNotEmpty) {
                  addEntry(firstName, lastName, healthStatus);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  showEditDialog(int index) {
    String firstName = entries[index]['firstName']!;
    String lastName = entries[index]['lastName']!;
    String healthStatus = entries[index]['healthStatus']!;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Entry'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'First Name'),
                controller: TextEditingController(text: firstName),
                onChanged: (value) {
                  firstName = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Last Name'),
                controller: TextEditingController(text: lastName),
                onChanged: (value) {
                  lastName = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Health Status'),
                controller: TextEditingController(text: healthStatus),
                onChanged: (value) {
                  healthStatus = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                if (firstName.isNotEmpty &&
                    lastName.isNotEmpty &&
                    healthStatus.isNotEmpty) {
                  editEntry(index, firstName, lastName, healthStatus);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
