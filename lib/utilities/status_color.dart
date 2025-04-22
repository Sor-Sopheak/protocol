import 'package:flutter/material.dart';
import 'package:protocol_app/models/status_enum.dart';

Color statusColor({
  required StatusEnum? status,
  required bool isText,
  required bool isBackground,
  required bool isStroke,
  required bool isIcon,
}) {
  if (status == null) {
    return isBackground
        ? (isIcon
            ? const Color(0xFF4B4B4B)
            : const Color(0xFFD9D9D9))
        : const Color(0xFF4B4B4B); 
  }

  switch (status) {
    case StatusEnum.draft:
      if (isText) return const Color(0xFF344054);
      if (isBackground) return const Color(0xFFE4E7EC);
      if (isStroke) return const Color(0xFFE4E7EC);
      break;

    case StatusEnum.inProgress:
      if (isText) return const Color(0xFFC46F00);
      if (isBackground) return const Color(0xFFFFFAEB); 
      if (isStroke) return const Color(0xFFFEC84B);
      break;

    case StatusEnum.confirmation:
      if (isText) return const Color(0xFF03B900);
      if (isBackground) return const Color(0xFF000000);
      if (isStroke) return const Color(0xFF000000);
      break;

    case StatusEnum.notAttending:
      if (isText) return const Color(0xFFE00025);
      if (isBackground) return const Color(0xFF000000);
      if (isStroke) return const Color(0xFF000000);
      break;
  }

  return const Color(0xFF000000);
}