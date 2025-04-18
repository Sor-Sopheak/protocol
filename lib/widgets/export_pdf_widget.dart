import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class ExportPdfWidget extends StatelessWidget {
  final List<Map<String, dynamic>> dataToExport = [
    {'name': 'Alice', 'age': 30},
    {'name': 'Bob', 'age': 25},
    {'name': 'Charlie', 'age': 35},
  ];

  ExportPdfWidget({super.key});

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
                    ...dataToExport
                        .map((user) => [user['name'], user['age'].toString()]),
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
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('PDF saved to: ${file.path}')));

    // Option 2: Share the PDF (requires share_plus package)
    // await Share.file('User Data', 'user_data.pdf', pdfBytes, 'application/pdf');

    // Option 3: Preview (you might already have this setup)
    // await Printing.layout(
    //   context: context,
    //   format: PdfPageFormat.a4,
    //   layout: PdfPageLayout.portrait,
    //   onLayout: (PdfPageFormat format) async => pdfBytes,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
          onPressed: () => _exportToPdf(context),
          child: const Text('Export to PDF'),
        ),
      );
  }
}
