import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:protocol_app/constants/color_constants.dart';
import 'package:protocol_app/models/event_model.dart';
import 'package:protocol_app/models/priority_level_enum.dart';
import 'package:protocol_app/models/status_enum.dart';
import 'package:protocol_app/pages/empty_data_content.dart';
import 'package:protocol_app/providers/event_provider.dart';
import 'package:protocol_app/widgets/button_with_icon_widget.dart';
import 'package:protocol_app/widgets/general_card_widget.dart';
import 'package:protocol_app/widgets/text_button_toggle_widget.dart';
import 'package:provider/provider.dart';

class TodayEventContent extends StatefulWidget {
  const TodayEventContent({super.key});

  @override
  State<TodayEventContent> createState() => _TodayEventContentState();
}

class _TodayEventContentState extends State<TodayEventContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchEvents();
    });
  }

  void _fetchEvents() {
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

  void _handleConfidentialityToggle(bool isPrimaryActive) {
    final provider = context.read<EventProvider>();
    setState(() {
      provider.isConfidential = isPrimaryActive;
      _fetchEvents();
    });
  }

  void _handlePriorityToggle(bool isPrimaryActive) {
    final provider = context.read<EventProvider>();
    setState(() {
      provider.priority =
          isPrimaryActive ? PriorityLevelEnum.urgent : PriorityLevelEnum.normal;
      _fetchEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EventProvider>(builder: (context, eventProvider, child) {
      if (eventProvider.isLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (eventProvider.events.isNotEmpty) {
        return Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      TextButtonToggleWidget(
                        title: 'Confidentiality',
                        primaryTitle: 'Confidential',
                        secondaryTitle: 'Non-confidential',
                        onToggle: _handleConfidentialityToggle,
                      ),
                      const SizedBox(width: 12),
                      TextButtonToggleWidget(
                        title: 'Priority',
                        primaryTitle: 'In Urgent',
                        secondaryTitle: 'Normal',
                        onToggle: _handlePriorityToggle,
                      ),
                      const SizedBox(width: 12),
                    ],
                  ),
                  const SizedBox(
                    width: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //search
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ListView.separated(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: eventProvider.events.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 24.0),
                itemBuilder: (BuildContext context, int index) {
                  final EventModel event = eventProvider.events[index];
                  return InkWell(
                    onTap: () {
                      GoRouter.of(context).go('/event/${event.id}');
                    },
                    child: GeneralCardWidget(
                      priority: PriorityLevelEnum.values.firstWhere(
                          (e) => e.name == event.priority,
                          orElse: () => PriorityLevelEnum.normal),
                      status: StatusEnum.values.firstWhere(
                          (e) => e.name == event.status,
                          orElse: () => StatusEnum.draft),
                    ),
                  );
                },
              )
            ],
          ),
        );
      } else {
        return Container(
          decoration: const BoxDecoration(
            color: Color(redColor)
          ),
          child: EmptyDataContent(
            title: 'You din\'t have any Event yet',
            subtitle: 'Please start by creating a new event.',
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
}
