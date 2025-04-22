import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:protocol_app/models/priority_level_enum.dart';
import 'package:protocol_app/models/status_enum.dart';
import 'package:protocol_app/widgets/general_card_widget.dart';
import 'package:protocol_app/widgets/text_button_toggle_widget.dart';

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
    status = StatusEnum.inProgress;
  }

  void _handleConfidentialityToggle(bool isPrimaryActive) {
    setState(() {
      _isConfidential = isPrimaryActive;
      priority = PriorityLevelEnum.urgent;
      status = StatusEnum.inProgress;
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
                  ),
                  const SizedBox(width: 12),
                  TextButtonToggleWidget(
                    title: 'Priority',
                    primaryTitle: 'In Urgent',
                    secondaryTitle: 'Normal',
                    onToggle: _handleConfidentialityToggle,
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
            itemCount: 5,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 24.0),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  GoRouter.of(context).go('/event/123');
                },
                child: GeneralCardWidget(priority: priority, status: status,),
              );
            },
          ),
        ],
      ),
    );
  }
}
