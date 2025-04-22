import 'package:flutter/material.dart';
import 'package:protocol_app/constants/color_constants.dart';

class RichTextWidget extends StatelessWidget {
  final String text;
  final String? textSpan;
  final TextStyle? textStyle;
  final String? iconPath;

  const RichTextWidget(
      {super.key,
      required this.text,
      this.textSpan,
      this.textStyle,
      this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (iconPath != null) ...[
          Image.asset(
            iconPath!,
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 16),
        ],
        RichText(
          text: TextSpan(
            text: text,
            style: textStyle ??
                const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(primaryTextColor)),
            children: <TextSpan>[
              TextSpan(
                text: textSpan,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(primaryTextColor)),
              ),
            ],
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
