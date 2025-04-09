import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          context.pushNamed('detail', pathParameters: {'id': '123'});
        },
        child: const Text('Go to Details'),
      ),
    );
  }
}
