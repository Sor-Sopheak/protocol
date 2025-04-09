import 'package:flutter/material.dart';
import 'package:protocol_app/models/text_field_type_enum.dart';
import 'package:protocol_app/widgets/standard_input_field_widget.dart';

class InputFieldWithLabelWidget extends StatefulWidget {
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
  const InputFieldWithLabelWidget({
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
  });

  @override
  State<InputFieldWithLabelWidget> createState() =>
      _InputFieldWithLabelWidgetState();
}

class _InputFieldWithLabelWidgetState extends State<InputFieldWithLabelWidget> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    Widget inputField;

    switch (widget.inputType) {
      case TextFieldTypeEnum.text:
        inputField = StandardInputFieldWidget(
          controller: widget.controller,
          inputType: TextFieldTypeEnum.text,
          placeholder: widget.placeholder,
          suffixIcon: widget.iconPath,
          readOnly: false,
        );
        break;
      case TextFieldTypeEnum.longText:
        inputField = StandardInputFieldWidget(
          controller: widget.controller,
          inputType: TextFieldTypeEnum.longText,
          placeholder: widget.placeholder,
          suffixIcon: widget.iconPath,
          readOnly: false,
        );
        break;
      case TextFieldTypeEnum.number:
        inputField = StandardInputFieldWidget(
          controller: widget.controller,
          inputType: TextFieldTypeEnum.number,
          placeholder: widget.placeholder,
          suffixIcon: widget.iconPath,
          readOnly: false,
        );
        break;
      case TextFieldTypeEnum.email:
        inputField = StandardInputFieldWidget(
          controller: widget.controller,
          inputType: TextFieldTypeEnum.email,
          placeholder: widget.placeholder,
          suffixIcon: widget.iconPath,
          readOnly: false,
        );
        break;
      case TextFieldTypeEnum.password:
        inputField = StandardInputFieldWidget(
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
      case TextFieldTypeEnum.datetime:
        inputField = StandardInputFieldWidget(
          controller: widget.controller,
          inputType: TextFieldTypeEnum.datetime,
          placeholder: widget.placeholder,
          suffixIcon: widget.iconPath,
          readOnly: false,
        );
        break;
      case TextFieldTypeEnum.file:
        inputField = StandardInputFieldWidget(
          controller: widget.controller,
          inputType: TextFieldTypeEnum.file,
          placeholder: widget.placeholder,
          suffixIcon: widget.iconPath,
          readOnly: false,
        );
        break;
      case TextFieldTypeEnum.dropdown:
        inputField = StandardInputFieldWidget(
          controller: widget.controller,
          inputType: TextFieldTypeEnum.dropdown,
          placeholder: widget.placeholder,
          suffixIcon: widget.iconPath,
          readOnly: false,
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
