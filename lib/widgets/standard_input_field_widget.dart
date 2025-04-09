import 'package:flutter/material.dart';
import 'package:protocol_app/models/text_field_type_enum.dart';

class StandardInputFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextFieldTypeEnum inputType;
  final String placeholder;
  final bool readOnly;
  final String? suffixIcon;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final bool obscureText;
  final VoidCallback? toggleObscure;
  const StandardInputFieldWidget({
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
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType.keyboardType,
      readOnly: readOnly,
      onChanged: onChanged,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: placeholder,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black,
              width: 2,
              strokeAlign: BorderSide.strokeAlignInside),
          borderRadius: BorderRadius.zero,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 2,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
          borderRadius: BorderRadius.zero,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 2,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
          borderRadius: BorderRadius.zero,
        ),
        suffixIcon: (inputType == TextFieldTypeEnum.password)
            ? IconButton(
                icon: ImageIcon(
                  AssetImage(
                    obscureText
                        ? 'assets/icons/invisibility_icon.png'
                        : 'assets/icons/visibility_icon.png',
                  ),
                ),
                onPressed: toggleObscure,
              )
            : (suffixIcon != null)
                ? IconButton(
                    icon: ImageIcon(
                      AssetImage(suffixIcon!),
                    ),
                    onPressed: toggleObscure,
                  )
                : const SizedBox(),
      ),
    );
  }
}
