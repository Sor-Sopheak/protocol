import 'package:flutter/material.dart';
import 'package:protocol_app/constants/color_constants.dart';
import 'package:protocol_app/models/priority_level_enum.dart';

class PriorityWidget extends StatelessWidget {
  final PriorityLevelEnum level;
  final double? size;
  const PriorityWidget({super.key, required this.level, this.size});

  @override
  Widget build(BuildContext context) {
    switch (level) {
      case PriorityLevelEnum.normal:
        return Container(
          decoration: BoxDecoration(
              color: const Color(blueColor),
              borderRadius: BorderRadius.circular(4)),
          margin: const EdgeInsets.only(right: 16),
          padding: const EdgeInsets.all(8),
          child: const Icon(
            Icons.lock,
            color: Color(whiteColor),
            size: 16,
          ),
        );
      case PriorityLevelEnum.urgent:
        return Container(
          decoration: BoxDecoration(
              color: const Color(redColor),
              borderRadius: BorderRadius.circular(4)),
          margin: const EdgeInsets.only(right: 16),
          padding: const EdgeInsets.all(8),
          child: const Icon(
            Icons.lock,
            color: Color(whiteColor),
            size: 16,
          ),
        );
    }
  }
}
