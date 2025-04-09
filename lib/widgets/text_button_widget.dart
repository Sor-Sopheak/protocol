import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  final VoidCallback btnAction;
  final String btnTitle;
  final bool isPrimary;
  final double? height;
  const TextButtonWidget({
    super.key,
    required this.btnAction,
    required this.btnTitle,
    required this.isPrimary,
    this.height = 36.0,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: btnAction,
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: isPrimary ? Colors.black : Colors.white,
          ),
          child: Center(
            child: Text(
              btnTitle,
              style: TextStyle(
                color: isPrimary ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
