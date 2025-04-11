import 'package:flutter/material.dart';

class RichTextWidget extends StatelessWidget {
  final String text;
  final String? textSpan;
  const RichTextWidget({super.key, required this.text, this.textSpan});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(
            text: textSpan,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
