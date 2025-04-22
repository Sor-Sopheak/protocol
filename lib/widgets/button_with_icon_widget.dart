import 'package:flutter/material.dart';
import 'package:protocol_app/constants/color_constants.dart';

class ButtonWithIconWidget extends StatelessWidget {
  final VoidCallback btnAction;
  final String? btnTitle;
  final Color? btnColor;
  final String iconPath;
  final Color? titleColor;
  final double? height;
  const ButtonWithIconWidget({
    super.key,
    required this.btnAction,
    this.btnTitle,
    this.btnColor,
    required this.iconPath,
    this.titleColor,
    this.height = 48,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: btnAction,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          height: height,
          decoration: BoxDecoration(
            color: btnColor ?? const Color(blueColor),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: btnColor ?? const Color(blueColor),
              width: 1,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconPath,
                width: 24,
                height: 24,
              ),
              if (btnTitle != null) ...[
                const SizedBox(width: 8),
                Text(
                  btnTitle!,
                  style: TextStyle(
                    color: titleColor ?? Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
