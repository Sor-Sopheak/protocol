import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:protocol_app/widgets/text_button_widget.dart';
import 'package:pdf/widgets.dart' as pw;

class PageHeaderWidget extends StatelessWidget {
  final String title;
  final bool isExport;
  final String? btnTitle;
  const PageHeaderWidget({
    super.key,
    required this.title,
    required this.isExport,
    this.btnTitle,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dataToExport = [
      {'name': 'Alice', 'age': 30},
      {'name': 'Bob', 'age': 25},
      {'name': 'Charlie', 'age': 35},
    ];

    Future<void> _exportToPdf(BuildContext context) async {
      final pdf = pw.Document();
      final pdfBytes = await pdf.save();

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Container(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('User Data Report',
                      style: pw.TextStyle(
                          fontSize: 20, fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(height: 20),
                  pw.TableHelper.fromTextArray(
                    context: context,
                    data: <List<String>>[
                      ['Name', 'Age'],
                      ...dataToExport.map(
                          (user) => [user['name'], user['age'].toString()]),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );

      // Option 1: Save to file
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/user_data.pdf');
      await file.writeAsBytes(pdfBytes);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('PDF saved to: ${file.path}')));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
        isExport == true
            ? TextButtonWidget(
                btnAction: () {
                  _exportToPdf(context);
                },
                btnTitle: btnTitle ?? '',
                titleColor: Colors.black,
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
