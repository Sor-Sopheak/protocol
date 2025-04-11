import 'dart:html' as html;
import 'dart:typed_data';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class FileUploadPreviewWidget extends StatefulWidget {
  const FileUploadPreviewWidget({super.key});

  @override
  State<FileUploadPreviewWidget> createState() =>
      _FileUploadPreviewWidgetState();
}

class _FileUploadPreviewWidgetState extends State<FileUploadPreviewWidget> {
  List<int>? _fileBytes;
  String _fileName = '';
  String? _fileType;

  Future<void> _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpeg', 'jpg'],
      withData: true,
    );

    if (result != null) {
      setState(() {
        _fileBytes = result.files.single.bytes;
        _fileName = result.files.single.name;

        _fileType = result.files.single.extension;
      });
    } else {
      // canceled the picker
    }
  }

  void _downloadFile() {
    if (_fileBytes != null) {
      final blob = html.Blob([_fileBytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', _fileName)
        ..click();
      html.Url.revokeObjectUrl(url);
    }
  }

  Widget _buildPreview() {
    if (_fileBytes == null) return const SizedBox.shrink();

    if (_fileType == 'jpg' || _fileType == 'jpeg' || _fileType == 'png') {
      return Image.memory(Uint8List.fromList(_fileBytes!));
    } else if (_fileType == 'pdf') {
      return SizedBox(
        height: 500,
        child: HtmlElementView(
        viewType: 'pdf-viewer',
      ),
        // child: PdfPreview(
        //   build: (format) async => Uint8List.fromList(_fileBytes!),
        //   canChangePageFormat: false,
        //   canChangeOrientation: false,
        //   allowSharing: false,
        //   allowPrinting: false,
        // ),
      );
    } else {
      return Text('Preview not available for $_fileType');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropTarget(
      onDragDone: (details) {},
      child: DottedBorder(
        borderType: BorderType.RRect,
        dashPattern: const [4, 4],
        radius: const Radius.circular(4),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.file_upload_outlined, size: 30),
            const SizedBox(height: 8),
            const Text('Drag and drop files here or'),
            TextButton(
              onPressed: _pickFiles,
              child: const Text('Choose files'),
            ),
            const SizedBox(height: 16),
            if (_fileBytes != null)
              ElevatedButton(
                onPressed: _downloadFile,
                child: const Text('Download File'),
              ),
            const SizedBox(height: 16),
            Expanded(child: _buildPreview()),
          ],
        ),
      ),
    );
  }
}
