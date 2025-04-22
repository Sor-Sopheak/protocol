import 'package:flutter/material.dart';
import 'package:protocol_app/constants/color_constants.dart';
import 'package:protocol_app/models/priority_level_enum.dart';
import 'package:protocol_app/models/status_enum.dart';
import 'package:protocol_app/widgets/flat_button_widget.dart';
import 'package:protocol_app/widgets/overview_card_event_widget.dart';
import 'package:protocol_app/widgets/reorderable_list_view_widget.dart';

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
    status = StatusEnum.inProgress;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
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
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  color: const Color(whiteColor),
                  child: const ReorderableListViewWidget(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}