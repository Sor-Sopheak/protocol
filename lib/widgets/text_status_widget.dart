import 'package:flutter/material.dart';

class TextStatusWidget extends StatelessWidget {
  final int count;
  final String statusTitle;
  const TextStatusWidget({
    super.key,
    required this.count,
    required this.statusTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black),
          ),
        ),
        Text(
          '$count $statusTitle',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
