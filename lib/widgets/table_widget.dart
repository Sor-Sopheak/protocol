import 'package:flutter/material.dart';
import 'package:protocol_app/constants/color_constants.dart';
import 'package:protocol_app/constants/string_constants.dart';

typedef TableDataExtractor<T> = String Function(T item);

class TableWidget<M> extends StatefulWidget {
  final List<String> itemHeader;
  final List<M> itemContent;
  final List<TableDataExtractor<M>> columnExtractors;
  final List<Widget>? actionsBuilders;
  final Widget? leadingCheckboxBuilder;
  const TableWidget({
    super.key,
    required this.itemHeader,
    required this.itemContent,
    required this.columnExtractors,
    this.actionsBuilders,
    this.leadingCheckboxBuilder,
  });

  @override
  State<TableWidget<M>> createState() => _TableWidgetState<M>();
}

class _TableWidgetState<M> extends State<TableWidget<M>> {
  late List<M> _currentContent;

  @override
  void initState() {
    super.initState();
    _currentContent = List.from(widget.itemContent);
  }

  Widget _tableHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 2, color: Color(darkGreyColor)),
          top: BorderSide(width: 2, color: Color(darkGreyColor)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 0, top: 12, bottom: 12),
            child: SizedBox(
              width: 24,
            ),
          ),
          const SizedBox(
            width: 56,
            child: Material(
              color: Color(whiteColor),
              child: Checkbox(
                activeColor: Colors.black,
                side: BorderSide(color: Color(greyColor), width: 1),
                value: false,
                onChanged: null,
              ),
            ),
          ),
          Container(
            width: 58,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: const Text(
              orderKh,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ...widget.itemHeader.map(
            (label) => Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          if (widget.actionsBuilders != null &&
              widget.actionsBuilders!.isNotEmpty)
            SizedBox(
              width: 60,
              child: const Text(
                actionKh,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _tableContent(BuildContext context) {
    return Expanded(
      child: ReorderableListView.builder(
        buildDefaultDragHandles: false,
        itemCount: _currentContent.length,
        itemBuilder: (context, index) {
          final item = _currentContent[index];
          return Container(
            key: ValueKey(item),
            decoration: const BoxDecoration(
              color: Color(whiteColor),
              border: Border(
                bottom: BorderSide(width: 1, color: Color(greyColor)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 0, top: 12, bottom: 12),
                  child: ReorderableDragStartListener(
                    index: index,
                    child: const Icon(
                      Icons.drag_handle_rounded,
                      size: 24,
                      color: Color(greyColor),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 56,
                  child: Material(
                    color: Color(whiteColor),
                    child: Checkbox(
                      activeColor: Colors.black,
                      side: BorderSide(color: Color(greyColor), width: 1),
                      value: false,
                      onChanged: null,
                    ),
                  ),
                ),
                Container(
                  width: 58,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text('${index + 1}'),
                ),
                ...widget.columnExtractors
                    .map((extractor) => Expanded(child: Text(extractor(item)))),
                if (widget.actionsBuilders != null &&
                    widget.actionsBuilders!.isNotEmpty &&
                    index < widget.actionsBuilders!.length)
                  Align(
                    alignment: Alignment.centerRight,
                    child: widget.actionsBuilders![index],
                  ),
              ],
            ),
          );
        },
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (oldIndex < newIndex) newIndex -= 1;
            final item = _currentContent.removeAt(oldIndex);
            _currentContent.insert(newIndex, item);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Column(
        children: [_tableHeader(context), _tableContent(context)],
      ),
    );
  }
}
