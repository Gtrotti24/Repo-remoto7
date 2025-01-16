import 'package:flutter/material.dart';

class AuthenticationTextFormField extends StatelessWidget {
  const AuthenticationTextFormField({
    this.confirmationController,
    required this.icon,
    required this.label,
    required this.textEditingController,
    super.key,
  });

  final TextEditingController? confirmationController;
  final IconData icon;
  final String label;
  final TextEditingController textEditingController;

  String? _validate(String? value) {
    if (value!.isEmpty) {
      return 'This field is required';
    }

    if (key.toString().contains('email') == true &&
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value) == false) {
      return 'This is not a valid email';
    }

    if (key.toString().contains('password') == true && value.length < 8) {
      return 'The password must be at least 8 characters long';
    }
    if (key.toString().contains('confirmation') == true &&
        value != confirmationController!.text) {
      return 'The passwords do not match';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: textEditingController,
      obscureText: label.toLowerCase().contains('password'),
      decoration: InputDecoration(
        floatingLabelStyle:
            theme.textTheme.titleLarge?.copyWith(color: Colors.white),
        icon: Icon(icon, color: Colors.white),
        labelText: label,
      ),
      validator: _validate,
    );
  }
}
