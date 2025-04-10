import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// class DateTimeFormatter {
//   String formatDate(DateTime? date, {String format = 'dd/MM/yyyy'}) {
//     if (date == null) return '';
//     return DateFormat(format).format(date);
//   }

//   String formatTime(BuildContext context, TimeOfDay? time) {
//     if (time == null) return '';
//     final now = DateTime.now();
//     final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
//     return TimeOfDay.fromDateTime(dt).format(context); // 12-hour with AM/PM
//   }
// }

class DateTimeFormatter {
  String formatDate(DateTime? date, {String format = 'dd/MM/yyyy'}) {
    if (date == null) return '';
    return DateFormat(format).format(date);
  }

  String formatTime(BuildContext context, TimeOfDay? time) {
    if (time == null) return '';
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat.jm().format(dt); // 12-hour with AM/PM using intl
  }
}