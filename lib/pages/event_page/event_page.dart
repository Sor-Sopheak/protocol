import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:protocol_app/constants/app_constants.dart';
import 'package:protocol_app/pages/empty_data_content.dart';
import 'package:protocol_app/pages/event_page/add_new_event.dart';
import 'package:protocol_app/pages/event_page/past_event_content.dart';
import 'package:protocol_app/pages/event_page/today_event_content.dart';
import 'package:protocol_app/pages/event_page/upcoming_event_content.dart';
import 'package:protocol_app/providers/event_provider.dart';
import 'package:protocol_app/utilities/custom_dialog.dart';
import 'package:protocol_app/widgets/button_with_icon_widget.dart';
import 'package:protocol_app/widgets/page_header_widget.dart';
import 'package:protocol_app/widgets/text_tab_button_widget.dart';
import 'package:provider/provider.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  int _activeTabIndex = 0;

  @override
  void initState() {
    super.initState();
    final provider = context.read<EventProvider>();
    provider.fetchEvents(
      provider.keyword,
      provider.isConfidential,
      provider.schedule,
      provider.status.name,
      provider.priority.name,
      1,
      10,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EventProvider>(builder: (context, eventProvider, child) {
      if (eventProvider.isLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (eventProvider.total > 0) {
        return _buildEventListContent(eventProvider);
      } else {
        return Container(
          color: Colors.white,
          child: EmptyDataContent(
            title: 'No Event Found',
            subtitle: 'Please create a new event',
            isbuttonVisible: true,
            button: ButtonWithIconWidget(
              btnAction: () {},
              iconPath: 'assets/icons/add.png',
              btnTitle: 'Create New Event',
            ),
          ),
        );
      }
    });
  }

  Widget _buildEventListContent(EventProvider eventProvider) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const PageHeaderWidget(
                  title: 'All Event',
                  isExport: false,
                ),
                ButtonWithIconWidget(
                  btnAction: () {
                    context.go('/event/addNewEvent');
                    // CustomDialog.show(
                    //   context: context,
                    //   layout: const AddNewEvent(),
                    //   title: 'Create New Event',
                    // );
                  },
                  iconPath: 'assets/icons/add.png',
                  btnTitle: 'Create New Event',
                ),
              ],
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black)),
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
      ),
    );
  }

  List<TextTabButtonWidget> generateTabButtons(
      int activeButtonIndex, Function(int) onPressed) {
    return List.generate(
      eventItems.length,
      (index) => TextTabButtonWidget(
        text: eventItems[index],
        count: 12,
        index: index,
        activeIndex: activeButtonIndex,
        onPressed: onPressed,
      ),
    );
  }

  Widget _getCurrentContent() {
    switch (_activeTabIndex) {
      case 0:
        return const TodayEventContent();
      case 1:
        return const UpcomingEventContent();
      case 2:
        return const PastEventContent();
      default:
        return const SizedBox.shrink();
    }
  }
}
