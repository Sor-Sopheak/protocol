import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  final VoidCallback btnAction;
  final String btnTitle;
  final bool? isPrimary;
  final String? iconPath;
  final Color? btnColor;
  final Color? titleColor;
  final double? height;
  const TextButtonWidget({
    super.key,
    required this.btnAction,
    required this.btnTitle,
    this.isPrimary = true,
    this.iconPath,
    this.btnColor,
    this.titleColor,
    this.height = 36.0,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: btnAction,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          height: height,
          decoration: BoxDecoration(
            color: btnColor ??
                (isPrimary == true
                    ? Colors.black
                    : isPrimary == false
                        ? Colors.white
                        : null),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (iconPath != null) ...[
                Image.asset(iconPath!),
              ],
              Text(
                btnTitle,
                style: TextStyle(
                  color: titleColor ??
                      (isPrimary == true
                          ? Colors.white
                          : isPrimary == false
                              ? Colors.black
                              : null),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
