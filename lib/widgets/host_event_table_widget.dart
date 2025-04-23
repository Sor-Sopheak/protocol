import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
// import 'package:web/web.dart' as web;
import 'dart:html' as html;

import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:protocol_app/constants/app_constants.dart';
import 'package:protocol_app/constants/color_constants.dart';
import 'package:protocol_app/widgets/drop_down_button_widget.dart';
import 'package:protocol_app/widgets/flat_button_widget.dart';
import 'package:protocol_app/widgets/search_widget.dart';
import 'package:protocol_app/widgets/table_widget.dart';
import 'package:protocol_app/widgets/text_button_widget.dart';

class HostEventTableWidget extends StatefulWidget {
  const HostEventTableWidget({super.key});

  @override
  State<HostEventTableWidget> createState() => _HostEventTableWidgetState();
}

class _HostEventTableWidgetState extends State<HostEventTableWidget> {
  final List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  String userSearchQuery = '';
  User? selectedUser;

  Future<void> _generatePdf() async {
    final pdf = pw.Document();
    final kantumruy = await PdfGoogleFonts.kantumruyProRegular();
    final kantumruyBold = await PdfGoogleFonts.kantumruyProBold();

    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) => [
          pw.Center(
            child: pw.Column(children: [
              pw.Text(
                'ព្រះរាជាណាចក្រកម្ពុជា',
                style: pw.TextStyle(
                  font: kantumruyBold,
                  fontSize: 12,
                  color: PdfColors.black,
                ),
              ),
              pw.Text(
                'ជាតិ សាសនា ព្រះមហាក្សត្រ',
                style: pw.TextStyle(
                  font: kantumruyBold,
                  fontSize: 12,
                  color: PdfColors.black,
                ),
              ),
              // pw.Text(
              //   '── ❈ ──',
              //   // '༺✧༻',
              //   style: pw.TextStyle(
              //     font: kantumruyBold,
              //     fontSize: 14,
              //     fontWeight: pw.FontWeight.bold,
              //     color: PdfColors.blue,
              //   ),
              // ),
            ]),
          ),
          pw.Table(
            border: pw.TableBorder.all(),
            columnWidths: const {
              0: pw.FlexColumnWidth(2),
              1: pw.FlexColumnWidth(2),
              2: pw.FlexColumnWidth(2),
            },
            children: [
              // Header Row with Background Color
              pw.TableRow(
                decoration:
                    const pw.BoxDecoration(color: PdfColors.blueGrey100),
                children: eventItems.map((title) {
                  return pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(
                      title,
                      style: pw.TextStyle(
                        font: kantumruy,
                        fontSize: 12,
                        color: PdfColors.black,
                      ),
                    ),
                  );
                }).toList(),
              ),

              // Data Rows
              ...allUsers.map((user) {
                return pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(
                        user.name,
                        style: pw.TextStyle(
                          font: kantumruy,
                          fontSize: 12,
                          color: PdfColors.black,
                        ),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(user.position),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(user.joinAs),
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
        ],
      ),
    );

    final pdfBytes = await pdf.save();

    // Create a PlatformFile-like object
    final platformFile = PlatformFile(
      name: 'users.pdf',
      bytes: pdfBytes,
      size: pdfBytes.length, // get the size
      path: null, // Path is not relevant for web Blob download
    );

    // Use your existing download function
    _downloadFile(platformFile);
  }

  void _downloadFile(PlatformFile file) {
    if (file.bytes != null) {
      final blob = html.Blob([file.bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', file.name)
        ..click();
      html.Url.revokeObjectUrl(url);
    }
  }

  Widget _header(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: Color(whiteColor),
          border:
              Border(bottom: BorderSide(color: Color(greyColor), width: 1))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'តារាងស្នើសុំសមាសភាព',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF202020)),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              const SizedBox(width: 16),
              FlatButtonWidget(
                title: 'Export',
                btnAction: () {
                  _generatePdf();
                },
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                borderColor: const Color(blueColor),
                borderRadius: BorderRadius.circular(4),
                btnColor: const Color(whiteColor),
                textStyle: const TextStyle(
                  color: Color(blueColor),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 16),
              FlatButtonWidget(
                iconPath: 'assets/icons/send.png',
                title: 'Send Invitation',
                btnAction: () {},
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                borderRadius: BorderRadius.circular(4),
                btnColor: const Color(orangeColor),
                textStyle: const TextStyle(
                  color: Color(whiteColor),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 16),
              TextButtonWidget(
                isPrimary: true,
                btnAction: () {},
                iconPath: 'assets/icons/add_circle.png',
                btnTitle: 'Send Invitation',
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _subHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 2,
            child: Row(
              children: [
                FlatButtonWidget(
                  iconPath: 'assets/icons/delete_white.png',
                  title: 'Remove',
                  btnAction: () {},
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  borderRadius: BorderRadius.circular(4),
                  btnColor: const Color(redColor),
                  textStyle: const TextStyle(
                    color: Color(whiteColor),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 16),
                DropDownButtonWidget(
                  listOptions: list,
                  iconPath: 'assets/icons/arrow_drop_down.png',
                  iconWidth: 24,
                  iconHeight: 24,
                ),
                const SizedBox(width: 16),
                DropDownButtonWidget(
                  listOptions: list,
                  iconPath: 'assets/icons/page_info.png',
                ),
              ],
            ),
          ),
          //search
          Flexible(
            flex: 1,
            child: SearchWidget<User>(
              items: allUsers,
              hintText: "Search...",
              searchIcon: true,
              onSearch: (query) {
                setState(() {
                  userSearchQuery = query;
                });
              },
              onItemSelected: (user) {
                setState(() {
                  selectedUser = user;
                });
              },
              onClear: () {
                setState(() {
                  selectedUser = null;
                  userSearchQuery = '';
                });
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _header(context),
        _subHeader(context),
        //customtable of user display
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          color: const Color(whiteColor),
          child: TableWidget<User>(
            itemHeader: eventItems,
            itemContent: allUsers,
            columnExtractors: [
              (user) => user.name,
              (user) => user.position,
              (user) => user.joinAs,
            ],
            actionsBuilders: const [Icon(Icons.delete)],
            leadingCheckboxBuilder:
                const Checkbox(value: false, onChanged: null),
          ),
        )
      ],
    );
  }
}
