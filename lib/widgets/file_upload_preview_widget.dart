import 'dart:html' as html;
import 'dart:ui_web' as ui_web;
import 'dart:typed_data';
import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileUploadPreviewWidget extends StatefulWidget {
  const FileUploadPreviewWidget({super.key});

  @override
  State<FileUploadPreviewWidget> createState() =>
      _FileUploadPreviewWidgetState();
}

class _FileUploadPreviewWidgetState extends State<FileUploadPreviewWidget> {
  PlatformFile? _singleFile;
  List<PlatformFile> _multipleFiles = [];
  Map<String, String> _pdfBase64s = {}; // This still works for both
  PlatformFile? _selectedPreviewFile;

  Future<void> _pickSingleFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpeg', 'jpg'],
      withData: true,
    );

    if (result != null && result.files.first.bytes != null) {
      setState(() {
        _singleFile = result.files.first;
        _selectedPreviewFile = null;
        print('Single file picked: ${_singleFile!.name}');

        if (_singleFile!.extension?.toLowerCase() == 'pdf') {
          _pdfBase64s[_singleFile!.name] = base64Encode(_singleFile!.bytes!);
        }
      });
    }
  }

  Future<void> _pickMultipleFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpeg', 'jpg'],
      withData: true,
    );

    if (result != null) {
      setState(() {
        final newFiles = result.files.where((f) => f.bytes != null);
        _multipleFiles.addAll(newFiles);
        _selectedPreviewFile = null;

        print('Multiple files picked:');
        for (var file in _multipleFiles) {
          print(' - ${file.name}');
          if (file.extension?.toLowerCase() == 'pdf') {
            _pdfBase64s[file.name] = base64Encode(file.bytes!);
          }
        }
      });
    }
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

  void _downloadAllFiles() {
    for (var file in _multipleFiles) {
      if (file.bytes != null) {
        final blob = html.Blob([file.bytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..setAttribute('download', file.name)
          ..click();
        html.Url.revokeObjectUrl(url);
      }
    }
    print('Downloaded ${_multipleFiles.length} files.');
  }

  Widget _buildSmallPreview(PlatformFile file) {
    final fileType = file.extension?.toLowerCase();

    return Column(
      children: [
        Text('File: ${file.name}'),
        const SizedBox(height: 8),
        if (fileType == 'pdf') ...[
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedPreviewFile = file;
              });
            },
            child: Container(
              width: 100,
              height: 120,
              color: Colors.grey.shade300,
              alignment: Alignment.center,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.picture_as_pdf, size: 40, color: Colors.red),
                  Text('Tap to preview', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          )
        ] else if (fileType == 'jpg' ||
            fileType == 'jpeg' ||
            fileType == 'png') ...[
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedPreviewFile = file;
              });
            },
            child: Image.memory(
              file.bytes!,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          )
        ],
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () => _downloadFile(file),
          child: const Text('Download'),
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildFullPreview() {
    if (_selectedPreviewFile == null) return const SizedBox.shrink();

    final file = _selectedPreviewFile!;
    final fileType = file.extension?.toLowerCase();

    if (fileType == 'pdf' && _pdfBase64s[file.name] != null) {
      final viewerId = 'pdf-viewer-${file.name.hashCode}';
      ui_web.platformViewRegistry.registerViewFactory(
        viewerId,
        (int viewId) {
          final iframe = html.IFrameElement()
            ..src = 'data:application/pdf;base64,${_pdfBase64s[file.name]}'
            ..style.border = 'none'
            ..style.width = '100%'
            ..style.height = '600px';
          return iframe;
        },
      );

      return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            Text('Preview: ${file.name}'),
            const SizedBox(height: 12),
            SizedBox(height: 600, child: HtmlElementView(viewType: viewerId)),
          ],
        ),
      );
    } else if (fileType == 'jpg' || fileType == 'jpeg' || fileType == 'png') {
      return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            Text('Preview: ${file.name}'),
            const SizedBox(height: 12),
            Image.memory(file.bytes!),
          ],
        ),
      );
    } else {
      return const Padding(
        padding: EdgeInsets.only(top: 16),
        child: Text('Preview not available.'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DottedBorder(
        borderType: BorderType.RRect,
        dashPattern: const [4, 4],
        radius: const Radius.circular(4),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.file_upload_outlined, size: 30),
            const SizedBox(height: 8),
            const Text('Upload a file'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: _pickSingleFile,
                  child: const Text('Upload Single File'),
                ),
                const SizedBox(width: 12),
                TextButton(
                  onPressed: _pickMultipleFiles,
                  child: const Text('Upload Multiple Files'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_singleFile != null) ...[
              const Text('Single File:'),
              _buildSmallPreview(_singleFile!),
            ],
            if (_multipleFiles.isNotEmpty) ...[
              const Text('Multiple Files:'),
              Row(
                children: _multipleFiles
                    .map((file) => _buildSmallPreview(file))
                    .toList(),
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: _downloadAllFiles,
                icon: const Icon(Icons.download),
                label: const Text('Download All'),
              ),
            ],
            if (_selectedPreviewFile != null) _buildFullPreview(),
          ],
        ),
      ),
    );
  }
}
