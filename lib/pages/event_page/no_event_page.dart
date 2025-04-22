import 'package:flutter/material.dart';

class NoEventPage extends StatelessWidget {
  const NoEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('You don\'t have any events yet'),
          const SizedBox(height: 20),
          Text('Please start by creating a new event'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
            },
            child: const Text('Create Event'),
          ),
        ],
      ),
    );
  }
}