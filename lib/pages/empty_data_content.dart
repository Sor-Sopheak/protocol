import 'package:flutter/material.dart';
import 'package:protocol_app/constants/color_constants.dart';

class EmptyDataContent extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isbuttonVisible;
  final Widget? button;
  const EmptyDataContent({
    super.key,
    required this.title,
    required this.subtitle,
    this.isbuttonVisible = true,
    this.button,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(blackColor),
            fontSize: 32,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          subtitle,
          style: const TextStyle(
            color: Color(primaryTextColor),
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        if (isbuttonVisible) ...[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 42),
                child: button,
              ),
            ],
          ),
        ],
        Image.asset(
          'assets/images/empty_data.jpg',
          width: 250,
        ),
      ],
    );
  }
}
