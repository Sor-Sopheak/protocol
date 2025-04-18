import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

class DataExportPreviewWidget extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> dataToExport;

  const DataExportPreviewWidget({
    super.key,
    required this.title,
    required this.dataToExport,
  });

  Future<void> _exportAndPreviewPdf(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Container(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(title,
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

    // await Printing.toPdf(
    //   format: PdfPageFormat.a4,
    //   layout: PdfPageLayout.portrait,
    //   onLayout: (PdfPageFormat format) async => pdf.save(),
    //   name: '${title.toLowerCase().replaceAll(' ', '_')}.pdf', // Suggest a filename
    // );
    // On web, this will open the PDF in a new tab with download/print options.
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(
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
              ElevatedButton(
                onPressed: () => _exportAndPreviewPdf(context),
                child: const Text('Export & Preview'),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: dataToExport.length,
            itemBuilder: (context, index) {
              final user = dataToExport[index];
              return ListTile(
                title: Text('Name: ${user['name']}'),
                subtitle: Text('Age: ${user['age']}'),
              );
            },
          ),
        ),
      ],
    );
  }
}

class EventPage extends StatelessWidget {
  const EventPage({super.key});

  final List<Map<String, dynamic>> eventData = const [
    {'name': 'Meeting with John', 'age': 30},
    {'name': 'Project Brainstorm', 'age': 28},
    {'name': 'Team Lunch', 'age': 32},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24.0),
      child: DataExportPreviewWidget(
        title: 'Event List',
        dataToExport: eventData,
      ),
    );
  }
}