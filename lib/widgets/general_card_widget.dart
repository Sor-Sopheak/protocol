import 'package:flutter/material.dart';

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
            RichText(
              text: TextSpan(
                text: '1.',
                style: DefaultTextStyle.of(context).style,
                children: const <TextSpan>[
                  TextSpan(
                    text:
                        'ជំនួបសំណេះសំណាលជាមួយក្រុមហ៊ុនទូរសព្ទចល័ត ក្រុមហ៊ុនបង្គោលអង់តែន និងក្រុមហ៊ុនបណ្តាញខ្សែកាបអុបទិកនៅកម្ពុជា',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const Divider(
              thickness: 1,
              color: Colors.black,
            ),
            RichText(
              text: TextSpan(
                text: 'Start date & Time: ',
                style: DefaultTextStyle.of(context).style,
                children: const <TextSpan>[
                  TextSpan(
                    text: 'Tue, Mar 01, 2025 9:30 AM',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                text: 'Location: ',
                style: DefaultTextStyle.of(context).style,
                children: const <TextSpan>[
                  TextSpan(
                    text:
                        'Innovation Center នៃបណ្ឌិត្យសភាបច្ចេកវិទ្យាឌីជីថលកម្ពុជា CADT',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.only(right: 4),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black)),
                    ),
                    const Text(
                      '4 Waiting for Confirmation',
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.only(right: 4),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black)),
                    ),
                    const Text(
                      '4 Waiting for Confirmation',
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.only(right: 4),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black)),
                    ),
                    const Text(
                      '4 Waiting for Confirmation',
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
