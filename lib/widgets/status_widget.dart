import 'package:flutter/material.dart';
import 'package:protocol_app/models/status_enum.dart';
import 'package:protocol_app/utilities/status_color.dart';

class StatusWidget extends StatelessWidget {
  final StatusEnum status;
  const StatusWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: statusColor(
          status: status,
          isText: false,
          isBackground: true,
          isStroke: false,
          isIcon: false,
        ),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: statusColor(
            status: status,
            isText: false,
            isBackground: false,
            isStroke: true,
            isIcon: false,
          ),
          width: 1,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
      ),
      child: Text(
        status.statusText,
        style: TextStyle(
          color: statusColor(
            status: status,
            isText: true,
            isBackground: false,
            isStroke: false,
            isIcon: false,
          ),
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
    );
  }
}
