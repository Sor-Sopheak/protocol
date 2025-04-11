import 'package:flutter/material.dart';
import 'package:protocol_app/widgets/text_button_widget.dart';

class PageHeaderWidget extends StatelessWidget {
  final String title;
  final bool isExport;
  final String? btnTitle;
  const PageHeaderWidget({
    super.key,
    required this.title,
    required this.isExport,
    this.btnTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
        isExport == true
            ? TextButtonWidget(
                btnAction: () {},
                btnTitle: btnTitle ?? '',
                btnColor: Colors.grey.shade200,
                titleColor: Colors.black,
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
