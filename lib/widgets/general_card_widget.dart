import 'package:flutter/material.dart';

import 'package:protocol_app/constants/color_constants.dart';
import 'package:protocol_app/constants/string_constants.dart';
import 'package:protocol_app/models/priority_level_enum.dart';
import 'package:protocol_app/models/status_enum.dart';
import 'package:protocol_app/widgets/priority_widget.dart';
import 'package:protocol_app/widgets/rich_text_widget.dart';
import 'package:protocol_app/widgets/status_widget.dart';
import 'package:protocol_app/widgets/text_status_widget.dart';

class GeneralCardWidget extends StatelessWidget {
  final PriorityLevelEnum priority;
  final StatusEnum status;
  const GeneralCardWidget(
      {super.key, required this.priority, required this.status});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: const BorderSide(
          color: Color(greyColor),
          width: 1.0,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    PriorityWidget(level: priority),
                    const RichTextWidget(
                      text:
                          'ជំនួបសំណេះសំណាលជាមួយក្រុមហ៊ុនទូរសព្ទចល័ត ក្រុមហ៊ុនបង្គោលអង់តែន និងក្រុមហ៊ុនបណ្តាញខ្សែកាបអុបទិកនៅកម្ពុជា',
                      textStyle: TextStyle(
                        color: Color(primaryTextColor),
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    StatusWidget(status: status),
                    const SizedBox(width: 16),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(blackColor)
                                .withAlpha((0.80 * 255).round()),
                            strokeAlign: BorderSide.strokeAlignInside,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Image.asset(
                          'assets/icons/dots_horizontal.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ],
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
                Row(
                  children: [
                    Image.asset('assets/icons/participants.png'),
                    const SizedBox(width: 8),
                    const Text(
                      '5 participants',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                const TextStatusWidget(
                  count: 3,
                  statusTitle: 'Waiting for Confirmation',
                ),
                const SizedBox(width: 16),
                const TextStatusWidget(
                  count: 1,
                  statusTitle: 'Comfirmation',
                  status: StatusEnum.confirmation,
                ),
                const SizedBox(width: 16),
                const TextStatusWidget(
                  count: 1,
                  statusTitle: 'Not Attending',
                  status: StatusEnum.notAttending,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
