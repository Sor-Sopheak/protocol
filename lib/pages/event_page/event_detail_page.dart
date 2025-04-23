import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:protocol_app/constants/app_constants.dart';
import 'package:protocol_app/constants/color_constants.dart';
import 'package:protocol_app/models/priority_level_enum.dart';
import 'package:protocol_app/models/status_enum.dart';
import 'package:protocol_app/pages/event_page/overview_event_content.dart';
import 'package:protocol_app/pages/event_page/past_event_content.dart';
import 'package:protocol_app/widgets/host_event_table_widget.dart';
import 'package:protocol_app/widgets/priority_widget.dart';
import 'package:protocol_app/widgets/rich_text_widget.dart';
import 'package:protocol_app/widgets/text_tab_button_widget.dart';

class EventDetailPage extends StatefulWidget {
  final String eventId;
  const EventDetailPage({super.key, required this.eventId});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  int _activeTabIndex = 0;
  late PriorityLevelEnum priority;
  late StatusEnum status;

  @override
  void initState() {
    super.initState();
    priority = PriorityLevelEnum.urgent;
    status = StatusEnum.inProgress;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(whiteColor),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 34),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Row(
                children: [
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          WidgetStateProperty.all(const Color(blueColor)),
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      padding: WidgetStateProperty.all(EdgeInsets.zero),
                      minimumSize: WidgetStateProperty.all(Size.zero),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      textStyle: WidgetStateProperty.all(
                        const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                          decorationThickness: 1.5,
                          decorationStyle: TextDecorationStyle.solid,
                        ),
                      ),
                    ),
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                    child: const Text('All Events'),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: Color(primaryTextColor),
                    ),
                  ),
                  const Text(
                    'សិក្ខាសាលាផ្សព្វផ្សាយលើកទី១ ស្តីពី «ការរៀបចំយុទ្ធសាស្ត្រជាតិស្ដីពីបញ្ញាសិប្បនិម្មិត»',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(blueColor),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
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
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(lightGreyColor),
                      ),
                    ),
                  ),
                  child: Row(
                    children: generateTabButtons(
                      _activeTabIndex,
                      (index) {
                        setState(() {
                          _activeTabIndex = index;
                        });
                      },
                    ),
                  ),
                ),
                _getCurrentContent(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<TextTabButtonWidget> generateTabButtons(
      int activeButtonIndex, Function(int) onPressed) {
    return List.generate(
      manageEventItems.length,
      (index) => TextTabButtonWidget(
        text: manageEventItems[index],
        index: index,
        activeIndex: activeButtonIndex,
        onPressed: onPressed,
      ),
    );
  }

  Widget _getCurrentContent() {
    switch (_activeTabIndex) {
      case 0:
        return const OverviewEventContent();
      case 1:
        return const HostEventTableWidget();
      case 2:
        return const PastEventContent();
      default:
        return const SizedBox.shrink();
    }
  }
}
