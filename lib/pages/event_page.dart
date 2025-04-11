import 'package:flutter/material.dart';
import 'package:protocol_app/widgets/file_upload_preview_widget.dart';
import 'package:protocol_app/widgets/general_card_widget.dart';
import 'package:protocol_app/widgets/page_header_widget.dart';
import 'package:protocol_app/widgets/text_tab_button_widget.dart';

class EventPage extends StatelessWidget {
  const EventPage({super.key});

  @override
  Widget build(BuildContext context) {
    int currentTabIndex = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fileController = TextEditingController();

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const PageHeaderWidget(title: 'Event List', isExport: true, btnTitle: 'Export'),
          Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black)),
            ),
            child: Row(
              children: generateTabButtons(
                currentTabIndex,
                (buttonIndex) {
                },
              ),
            ),
          ),
          const GeneralCardWidget(),

          SizedBox(
            width: 500,
            height: 300,
            child: Form(
              key: _formKey,
              child: FileUploadPreviewWidget(), 
            ),
          )
        ],
      ),
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
