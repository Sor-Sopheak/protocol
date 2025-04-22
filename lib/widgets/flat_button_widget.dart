import 'package:flutter/material.dart';
import 'package:protocol_app/constants/color_constants.dart';

class FlatButtonWidget extends StatelessWidget {
  final VoidCallback btnAction;
  final String title;
  final String? iconPath;
  final Color? btnColor;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final double? iconWidth;
  final double? iconHeight;
  const FlatButtonWidget({
    super.key,
    required this.btnAction,
    required this.title,
    this.iconPath,
    this.btnColor,
    this.textStyle,
    this.padding,
    this.borderColor,
    this.borderRadius,
    this.iconWidth = 24,
    this.iconHeight = 24,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: btnAction,
        child: Container(
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: btnColor ??
                const Color(blackColor).withAlpha((0.06 * 255).round()),
            border:
                borderColor != null ? Border.all(color: borderColor!) : null,
            borderRadius: borderRadius ?? BorderRadius.zero,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                if (iconPath != null) ...[
                  Image.asset(
                    iconPath!,
                    width: iconWidth,
                    height: iconHeight,
                  ),
                  const SizedBox(width: 5),
                ],
                Text(
                  title,
                  style: textStyle ??
                      TextStyle(
                        color: const Color(blackColor)
                            .withAlpha((0.8 * 255).round()),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
