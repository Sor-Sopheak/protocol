import 'package:flutter/material.dart';
import 'package:protocol_app/constants/color_constants.dart';
import 'package:protocol_app/models/text_field_type_enum.dart';

class InputFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final TextFieldTypeEnum inputType;
  final String placeholder;
  final bool readOnly;
  final String? suffixIcon;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final bool obscureText;
  final VoidCallback? toggleObscure;
  final int? maxline;
  final int? maxLength;
  const InputFieldWidget({
    super.key,
    required this.controller,
    required this.inputType,
    required this.placeholder,
    required this.readOnly,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.obscureText = false,
    this.toggleObscure,
    this.maxline = 1,
    this.maxLength,
  });

  @override
  State<InputFieldWidget> createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  bool _isHovering = false;
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() {
        _isHovering = true;
      }),
      onExit: (event) => setState(() {
        _isHovering = false;
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: _isFocused
              ? [
                  BoxShadow(
                    color: const Color(blueColor).withAlpha(
                        (0.3 * 255).round()), //30% opacity using withAlpha
                    spreadRadius: 2,
                    blurRadius: 0,
                    offset: const Offset(0, 0),
                  ),
                ]
              : _isHovering
                  ? [
                      BoxShadow(
                        color: const Color(greyColor)
                            .withAlpha((0.3 * 255).round()),
                        spreadRadius: 2,
                        blurRadius: 1,
                        offset: const Offset(0, 0),
                      ),
                    ]
                  : null,
        ),
        child: TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          keyboardType: widget.inputType.keyboardType,
          readOnly: widget.readOnly,
          onChanged: widget.onChanged,
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: widget.obscureText,
          maxLines: widget.maxline,
          maxLength: widget.maxLength,
          cursorColor: const Color(blueColor),
          cursorWidth: 1,
          decoration: InputDecoration(
            hintText: widget.placeholder,
            fillColor: const Color(whiteColor),
            filled: true,
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(greyColor),
                width: 1,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(greyColor),
                width: 1,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(blueColor),
                width: 1,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            suffixIcon: (widget.inputType == TextFieldTypeEnum.password)
                ? IconButton(
                    icon: ImageIcon(
                      AssetImage(
                        widget.obscureText
                            ? 'assets/icons/invisibility_icon.png'
                            : 'assets/icons/visibility_icon.png',
                      ),
                    ),
                    onPressed: widget.toggleObscure,
                  )
                : (widget.suffixIcon != null)
                    ? IconButton(
                        icon: ImageIcon(
                          AssetImage(widget.suffixIcon!),
                        ),
                        onPressed: widget.toggleObscure,
                      )
                    : const SizedBox(),
          ),
        ),
      ),
    );
  }
}
