import 'package:flutter/material.dart';
import 'package:protocol_app/models/status_enum.dart';
import 'package:protocol_app/utilities/status_color.dart';

class TextStatusWidget extends StatelessWidget {
  final int count;
  final String statusTitle;
  final StatusEnum? status;
  const TextStatusWidget({
    super.key,
    required this.count,
    required this.statusTitle,
    this.status,
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
          style: TextStyle(
            color: statusColor(
              status: status,
              isText: true,
              isBackground: false,
              isStroke: false,
              isIcon: false,
            ),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
