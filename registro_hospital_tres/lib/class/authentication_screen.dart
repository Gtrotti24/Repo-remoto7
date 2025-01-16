import 'package:flutter/material.dart';
import 'package:registro_hospital_tres/class/authentication_text_form_field.dart';
import 'package:registro_hospital_tres/class/wave.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  bool register = true;

  Future<void> _authenticate() async {
    if (_formKey.currentState!.validate() == false) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
      'Registro Exitoso',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 20),
    )));

    {
      // Implement the authentication logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 232, 237),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Wave(),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    AuthenticationTextFormField(
                      key: const Key("email"),
                      icon: Icons.email,
                      label: 'Email',
                      textEditingController: emailController,
                    ),
                    AuthenticationTextFormField(
                      key: const Key("password"),
                      icon: Icons.vpn_key,
                      label: 'Password',
                      textEditingController: passwordController,
                    ),
                    if (register == true)
                      AuthenticationTextFormField(
                        key: const Key("passwordConfirmation"),
                        icon: Icons.password,
                        label: 'Password Confirmation',
                        textEditingController: passwordConfirmationController,
                        confirmationController: passwordController,
                      ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () {
                        _authenticate();
                      },
                      child: Text(
                        register == true ? 'Registrar' : 'Login',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                    BackButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}