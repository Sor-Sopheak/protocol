import 'package:flutter/material.dart';
import 'package:protocol_app/constants/color_constants.dart';
import 'package:protocol_app/constants/string_constants.dart';
import 'package:protocol_app/models/priority_level_enum.dart';
import 'package:protocol_app/models/status_enum.dart';
import 'package:protocol_app/widgets/rich_text_widget.dart';
import 'package:protocol_app/widgets/status_widget.dart';

class OverviewCardEventWidget extends StatelessWidget {
  final PriorityLevelEnum priority;
  final StatusEnum status;
  const OverviewCardEventWidget(
      {super.key, required this.priority, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      color: const Color(whiteColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            color: Color(0xFFD0D5DD),
            height: 1,
            thickness: 1,
          ),
          const SizedBox(height: 16),
          const RichTextWidget(
            iconPath: 'assets/icons/dots_horizontal.png',
            text: '$dateKh: ',
            textSpan: ' ថ្ងៃទី25 ខែ​មីនា ឆ្នាំ2025',
          ),
          const SizedBox(height: 16),
          const RichTextWidget(
            iconPath: 'assets/icons/dots_horizontal.png',
            text: '$timeKh: ',
            textSpan: ' 1:30 PM ដល់ 5:00 PM',
          ),
          const SizedBox(height: 16),
          const RichTextWidget(
            iconPath: 'assets/icons/dots_horizontal.png',
            text: '$locationKh: ',
            textSpan:
                ' ទីស្ដីការក្រសួងប្រៃសណីយ៍និងទូរគមនាគមន៍, អគារ “ក”,  ជាន់ទី ៣, បន្ទប់ សាលប្រជុំ A3',
          ),
          const SizedBox(height: 16),
          const StatusWidget(status: StatusEnum.inProgress),
          const SizedBox(height: 16),
          const Divider(
            color: Color(0xFFD0D5DD),
            height: 1,
            thickness: 1,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Image.asset('assets/icons/participants.png'),
              const SizedBox(width: 8),
              const Text(
                '-',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
