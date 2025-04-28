import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  final String title;
  final String description;
  const LoginHeader({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          description,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
