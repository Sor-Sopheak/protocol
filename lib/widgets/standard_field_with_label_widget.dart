import 'dart:io';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:protocol_app/models/text_field_type_enum.dart';
import 'package:protocol_app/utilities/date_time_formatter.dart';
import 'package:protocol_app/widgets/input_field_widget.dart';

class StandardFieldWithLabelWidget extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String placeholder;
  final String? iconPath;
  final bool isOptional;
  final TextFieldTypeEnum inputType;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final List<String>? options;
  final List<String>? Function(List<String>?)? onChangedOption;
  final List<String>? dropdownItems;
  final bool isStartTime;

  const StandardFieldWithLabelWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.placeholder,
    this.iconPath,
    required this.isOptional,
    required this.inputType,
    this.validator,
    this.onChanged,
    this.options,
    this.onChangedOption,
    this.dropdownItems,
    this.isStartTime = true,
  });

  @override
  State<StandardFieldWithLabelWidget> createState() =>
      _StandardFieldWithLabelWidgetState();
}

class _StandardFieldWithLabelWidgetState
    extends State<StandardFieldWithLabelWidget> {
  bool _obscureText = true;
  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  List<PlatformFile> _pickedFiles = [];
  String _fileErrorMessage = '';

  final DateTimeFormatter _dateFormatter = DateTimeFormatter();

  @override
  void initState() {
    super.initState();
    if (widget.inputType == TextFieldTypeEnum.dropdown &&
        widget.dropdownItems != null &&
        widget.dropdownItems!.isNotEmpty) {
      widget.controller.text = widget.dropdownItems!.first;
    }
  }

  Future<String?> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(9999),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.grey,
              accentColor: Colors.black,
              backgroundColor: Colors.black,
              cardColor: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        widget.controller.text = _dateFormatter.formatDate(_selectedDate!);
      });
      widget.onChanged?.call(widget.controller.text);
    }
    return null;
  }

  Future<void> _selectTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        if (widget.isStartTime) {
          _startTime = pickedTime;
          widget.controller.text = pickedTime.format(context);
        } else {
          if (_startTime != null) {
            if (pickedTime.hour < _startTime!.hour ||
                (pickedTime.hour == _startTime!.hour &&
                    pickedTime.minute < _startTime!.minute)) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content:
                        Text('End time cannot be earlier than start time.')),
              );
              return;
            }
          }
          _endTime = pickedTime;
          widget.controller.text = pickedTime.format(context);
        }
      });
      if (!widget.isStartTime &&
          _startTime != null &&
          (pickedTime.hour < _startTime!.hour ||
              (pickedTime.hour == _startTime!.hour &&
                  pickedTime.minute < _startTime!.minute))) {
        return; 
      }

      widget.onChanged?.call(widget.controller.text);
    }
  }

  Future<void> _pickFiles() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
        allowMultiple: true,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _pickedFiles = result.files;
          _fileErrorMessage = '';
        });
        _validateFilesSize();
      }
    } catch (e) {
      print("Error picking files: $e");
    }
  }

  void _validateFilesSize() {
    int totalSize = 0;
    for (var file in _pickedFiles) {
      totalSize += file.size;
    }

    if (totalSize > 15 * 1024 * 1024) {
      // 15 MB in bytes
      setState(() {
        _fileErrorMessage = 'Total file size exceeds 15MB.';
        _pickedFiles = [];
      });
    }
    widget.onChanged?.call(_pickedFiles.map((file) => file.name).join(', '));
  }

  @override
  Widget build(BuildContext context) {
    Widget inputField;

    switch (widget.inputType) {
      case TextFieldTypeEnum.text:
        inputField = InputFieldWidget(
          controller: widget.controller,
          inputType: TextFieldTypeEnum.text,
          placeholder: widget.placeholder,
          suffixIcon: widget.iconPath,
          readOnly: false,
        );
        break;
      case TextFieldTypeEnum.longText:
        inputField = InputFieldWidget(
          controller: widget.controller,
          inputType: TextFieldTypeEnum.longText,
          placeholder: widget.placeholder,
          suffixIcon: 'assets/icons/close.png',
          readOnly: false,
          maxline: 2,
          maxLength: 50,
          toggleObscure: () {
            setState(() {
              widget.controller.clear();
            });
          },
        );
        break;
      case TextFieldTypeEnum.number:
        inputField = InputFieldWidget(
          controller: widget.controller,
          inputType: TextFieldTypeEnum.number,
          placeholder: widget.placeholder,
          suffixIcon: widget.iconPath,
          readOnly: false,
        );
        break;
      case TextFieldTypeEnum.email:
        inputField = InputFieldWidget(
          controller: widget.controller,
          inputType: TextFieldTypeEnum.email,
          placeholder: widget.placeholder,
          suffixIcon: 'assets/icons/info.png',
          readOnly: false,
        );
        break;
      case TextFieldTypeEnum.password:
        inputField = InputFieldWidget(
          controller: widget.controller,
          inputType: TextFieldTypeEnum.password,
          placeholder: widget.placeholder,
          readOnly: false,
          obscureText: _obscureText,
          onChanged: widget.onChanged,
          toggleObscure: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        );
        break;
      case TextFieldTypeEnum.date:
        inputField = Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: InputFieldWidget(
                controller: widget.controller,
                inputType: TextFieldTypeEnum.date,
                placeholder: widget.placeholder,
                suffixIcon: widget.iconPath,
                readOnly: false,
                validator: widget.validator,
                onChanged: widget.onChanged,
              ),
            ),
            InkWell(
              onTap: () {
                _selectDate(context);
              },
              child: Ink(
                padding: EdgeInsets.zero,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  decoration: const BoxDecoration(
                    color: Color(0xFF1C4076),
                    border: Border(
                      top: BorderSide(width: 2, color: Colors.black),
                      bottom: BorderSide(width: 2, color: Colors.black),
                      right: BorderSide(width: 2, color: Colors.black),
                    ),
                    borderRadius: BorderRadius.zero,
                  ),
                  child: const Icon(
                    Icons.date_range_outlined,
                    color: Color(0xFF555F75),
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        );
        break;
      case TextFieldTypeEnum.time:
        inputField = InputFieldWidget(
          controller: widget.controller,
          inputType: widget.inputType,
          placeholder: widget.placeholder,
          suffixIcon: 'assets/icons/time.png',
          readOnly: true,
          validator: widget.validator,
          onChanged: widget.onChanged,
          toggleObscure: () async {
            await _selectTime(context);
          },
        );
        break;
      case TextFieldTypeEnum.file:
        inputField = DropTarget(
          onDragDone: (details) {
            setState(() {
              _pickedFiles = details.files
                  .map((file) => PlatformFile(
                        name: file.path.split('/').last,
                        path: file.path,
                        size: File(file.path).lengthSync(),
                      ))
                  .toList();
              _fileErrorMessage = '';
            });
            _validateFilesSize();
          },
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
                if (_fileErrorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      _fileErrorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                if (_pickedFiles.isNotEmpty)
                  Column(
                    children:
                        _pickedFiles.map((file) => Text(file.name)).toList(),
                  ),
              ],
            ),
          ),
        );
        break;
      case TextFieldTypeEnum.dropdown:
        inputField = PopupMenuTheme(
          data: PopupMenuThemeData(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
              menuPadding: const EdgeInsets.symmetric(vertical: 5)),
          child: PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              List<PopupMenuEntry<String>> menuItems = [];
              for (int i = 0; i < widget.dropdownItems!.length; i++) {
                menuItems.add(
                  PopupMenuItem<String>(
                    value: widget.dropdownItems![i],
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: const Border(
                            bottom: BorderSide(color: Colors.black)),
                        color:
                            widget.controller.text == widget.dropdownItems![i]
                                ? Colors.grey.shade300
                                : Colors.transparent,
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Text(widget.dropdownItems![i]),
                    ),
                  ),
                );
                if (i < widget.dropdownItems!.length - 1 &&
                    widget.dropdownItems!.length > 2) {
                  menuItems.add(const PopupMenuDivider(height: 1));
                }
              }
              return menuItems;
            },
            onSelected: (String choice) {
              setState(() {
                widget.controller.text = choice;
              });
              widget.onChanged?.call(choice);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.controller.text.isEmpty
                        ? widget.placeholder
                        : widget.controller.text,
                    style: TextStyle(
                      color: widget.controller.text.isEmpty
                          ? Colors.black
                          : Colors.green,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Image.asset(
                    'assets/icons/down_arrow.png',
                    width: 24,
                    height: 24,
                    color: Colors.grey.shade600,
                  ),
                ],
              ),
            ),
          ),
        );
        break;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: widget.label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            children: widget.isOptional
                ? []
                : [
                    WidgetSpan(
                      child: Transform.translate(
                        offset: const Offset(0, -5),
                        child: const Text(
                          '*',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
          ),
        ),
        const SizedBox(height: 4),
        inputField,
      ],
    );
  }
}
