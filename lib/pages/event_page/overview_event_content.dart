import 'package:flutter/material.dart';
import 'package:protocol_app/constants/app_constants.dart';
import 'package:protocol_app/constants/color_constants.dart';
import 'package:protocol_app/models/participant_model.dart';
import 'package:protocol_app/models/priority_level_enum.dart';
import 'package:protocol_app/models/status_enum.dart';
import 'package:protocol_app/providers/participant_provider.dart';
import 'package:protocol_app/widgets/flat_button_widget.dart';
import 'package:protocol_app/widgets/overview_card_event_widget.dart';
import 'package:protocol_app/widgets/table_widget.dart';
import 'package:provider/provider.dart';

class OverviewEventContent extends StatefulWidget {
  const OverviewEventContent({super.key});

  @override
  State<OverviewEventContent> createState() => _OverviewEventContentState();
}

class _OverviewEventContentState extends State<OverviewEventContent> {
  late PriorityLevelEnum priority;
  late StatusEnum status;

  @override
  void initState() {
    super.initState();
    priority = PriorityLevelEnum.urgent;
    status = StatusEnum.all;
    priority = PriorityLevelEnum.urgent;
    status = StatusEnum.all;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ParticipantProvider>().fetchParticipants(
            null,
            null,
            1,
            10,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final participantProvider = context.watch<ParticipantProvider>();
    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: 0,
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 24.0),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {},
              child:
                  OverviewCardEventWidget(priority: priority, status: status),
            );
          },
        ),
        Container(
          color: const Color(blackColor).withAlpha((0.05 * 255).round()),
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hosts',
                          style: TextStyle(
                              color: Color(blackColor),
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Add more hosts to manage the event',
                          style: TextStyle(
                              color: Color(secondaryTextColor),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    FlatButtonWidget(
                      iconPath: 'assets/icons/add.png',
                      title: 'Add Host',
                      btnAction: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                color: const Color(whiteColor),
                child: Consumer<ParticipantProvider>(
                  builder: (context, value, child) {
                    if (participantProvider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (participantProvider.participants.isNotEmpty) {
                      return SizedBox(
                        height: 500,
                        child:
                            TableWidget<ParticipantModel, ParticipantProvider>(
                          itemHeader: eventItems,
                          itemContent: participantProvider.participants,
                          columnExtractors: [
                            (participant) => participant.khName,
                            (participant) => participant.enName,
                            (participant) => participant.position,
                          ],
                          idExtractor: (participant) =>
                              participant.id.toString(),
                          isSelected: (participant) => participantProvider
                              .selectedItemIds
                              .contains(participant.id.toString()),
                          toggleSelection: (itemId, isSelected) {
                            participantProvider.toggleSelection(
                                itemId, isSelected);
                          },
                          toggleSelectAll: participantProvider.toggleSelectAll,
                          getItems: (p) => p.participants,
                          provider: participantProvider,
                          actionsBuilders: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.delete,
                                    size: 14,
                                  ),
                                  Text('Remove')
                                ],
                              ),
                            ),
                            const Icon(Icons.delete),
                            const Icon(Icons.visibility)
                          ],
                          leadingCheckboxBuilder:
                              const Checkbox(value: false, onChanged: null),
                        ),
                      );
                    } else {
                      return const Center(child: Text('No hosts found.'));
                    }
                  },
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
