import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:protocol_app/models/event_model.dart';
import 'package:protocol_app/models/priority_level_enum.dart';
import 'package:protocol_app/models/status_enum.dart';
import 'package:protocol_app/providers/event_provider.dart';
import 'package:protocol_app/widgets/general_card_widget.dart';
import 'package:protocol_app/widgets/text_button_toggle_widget.dart';
import 'package:provider/provider.dart';

class TodayEventContent extends StatefulWidget {
  const TodayEventContent({super.key});

  @override
  State<TodayEventContent> createState() => _TodayEventContentState();
}

class _TodayEventContentState extends State<TodayEventContent> {
  bool _isConfidential = true;
  late PriorityLevelEnum priority;
  late StatusEnum status;

  @override
  void initState() {
    super.initState();
    priority = PriorityLevelEnum.urgent;
    status = StatusEnum.all;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchEvents();
    });
  }

  void _fetchEvents() {
    context.read<EventProvider>().fetchEvents(
          null,
          _isConfidential,
          'all',
          'all',
          'all',
          1,
          10,
        );
  }

  void _handleConfidentialityToggle(bool isPrimaryActive) {
    setState(() {
      _isConfidential = isPrimaryActive;
      priority = PriorityLevelEnum.urgent;
      _fetchEvents();
    });
  }

  void _handlePriorityToggle(bool isPrimaryActive) {
    setState(() {
      priority =
          isPrimaryActive ? PriorityLevelEnum.urgent : PriorityLevelEnum.normal;
      _fetchEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    // initialPrimaryActive: _isConfidential,
                  ),
                  const SizedBox(width: 12),
                  TextButtonToggleWidget(
                    title: 'Priority',
                    primaryTitle: 'In Urgent',
                    secondaryTitle: 'Normal',
                    onToggle: _handlePriorityToggle,
                    // nitialPrimaryActive: _priority == PriorityLevelEnum.urgent,
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
          Consumer<EventProvider>(builder: (context, eventProvider, child) {
            if (eventProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (eventProvider.events.isNotEmpty) {
              return ListView.separated(
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
              );
            } else {
              return const Center(child: Text('No events found.'));
            }
          }),
        ],
      ),
    );
  }
}
