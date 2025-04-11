import 'package:flutter/material.dart';
import 'package:protocol_app/widgets/rich_text_widget.dart';
import 'package:protocol_app/widgets/text_status_widget.dart';

class GeneralCardWidget extends StatelessWidget {
  const GeneralCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: const BorderSide(
          color: Colors.black,
          width: 1.0,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red.shade200,
                shape: BoxShape.rectangle,
              ),
              child: const Text(
                'Hight Priority',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const RichTextWidget(
              text: '1. ',
              textSpan:
                  'ជំនួបសំណេះសំណាលជាមួយក្រុមហ៊ុនទូរសព្ទចល័ត ក្រុមហ៊ុនបង្គោលអង់តែន និងក្រុមហ៊ុនបណ្តាញខ្សែកាបអុបទិកនៅកម្ពុជា',
            ),
            const Divider(
              thickness: 1,
              color: Colors.black,
            ),
            const RichTextWidget(
              text: 'Start date & Time: ',
              textSpan: 'Tue, Mar 01, 2025 9:30 AM',
            ),
            const SizedBox(height: 16),
            const RichTextWidget(
              text: 'Location: ',
              textSpan:
                  'Innovation Center នៃបណ្ឌិត្យសភាបច្ចេកវិទ្យាឌីជីថលកម្ពុជា CADT',
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Row(
                  children: [
                    Image.asset('assets/icons/participants.png'),
                    const Text(
                      '5 participants',
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                ),
                const SizedBox(width: 16),
                const TextStatusWidget(
                  count: 1,
                  statusTitle: 'Not Attending',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
