import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:protocol_app/widgets/general_card_widget.dart';
import 'package:protocol_app/widgets/text_tab_button_widget.dart';

class EventPage extends StatelessWidget {
  const EventPage({super.key});

  @override
  Widget build(BuildContext context) {
    int currentTabIndex = 0;

    return Column(
      children: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              context.pushNamed('detail', pathParameters: {'id': '123'});
            },
            child: const Text('Go to Details'),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black)),
          ),
          child: Row(
            children: generateTabButtons(
              currentTabIndex,
              (buttonIndex) {},
            ),
          ),
        ),
        GeneralCardWidget(),
      ],
    );
  }

  List<TextTabButtonWidget> generateTabButtons(
      int activeButtonIndex, Function(int) onPressed) {
    final buttonTexts = ['Today Event', 'Upping Event', 'Past Event'];
    return List.generate(
      buttonTexts.length,
      (index) => TextTabButtonWidget(
        text: buttonTexts[index],
        count: 12,
        index: index,
        activeIndex: activeButtonIndex,
        onPressed: onPressed,
      ),
    );
  }
}
