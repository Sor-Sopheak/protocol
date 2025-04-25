import 'package:flutter/material.dart';
import 'package:protocol_app/constants/color_constants.dart';
import 'package:protocol_app/constants/string_constants.dart';

typedef TableDataExtractor<T> = String Function(T item);
typedef IdExtractor<T> = String Function(T item);
typedef IsItemSelected<T> = bool Function(T item);
typedef OnItemSelected<T> = void Function(String itemId, bool isSelected);
typedef OnSelectAll<T> = void Function(bool isSelected);
typedef GetItems<T, P> = List<T> Function(P provider);

class TableWidget<M, P> extends StatefulWidget {
  final List<String> itemHeader;
  final List<M> itemContent;
  final List<TableDataExtractor<M>> columnExtractors;
  final List<Widget>? actionsBuilders;
  final IdExtractor<M>? idExtractor;
  final IsItemSelected<M>? isSelected;
  final OnItemSelected<M>? toggleSelection;
  final OnSelectAll<M>? toggleSelectAll;
  final GetItems<M, P> getItems;
  final P provider;
  final Widget? leadingCheckboxBuilder;
  const TableWidget({
    super.key,
    required this.itemHeader,
    required this.itemContent,
    required this.columnExtractors,
    this.actionsBuilders,
    this.idExtractor,
    this.isSelected,
    this.toggleSelection,
    this.toggleSelectAll,
    required this.getItems,
    required this.provider,
    this.leadingCheckboxBuilder,
  });

  @override
  State<TableWidget<M, P>> createState() => _TableWidgetState<M, P>();
}

class _TableWidgetState<M, P> extends State<TableWidget<M, P>> {
  late List<M> _currentContent;
  Set<String> selectedItemIds = {};

  @override
  void initState() {
    super.initState();
    _currentContent = List.from(widget.itemContent);
    _initializeSelections();
  }

  void _initializeSelections() {
    selectedItemIds.clear();
    if (widget.idExtractor == null || widget.isSelected == null) return;
    for (var item in widget.getItems(widget.provider)) {
      if (widget.isSelected!(item)) {
        selectedItemIds.add(widget.idExtractor!(item));
      }
    }
  }

  void toggleRowSelection(String itemId, bool? isSelected) {
    setState(() {
      if (isSelected != null && widget.toggleSelection != null) {
        if (isSelected) {
          selectedItemIds.add(itemId);
        } else {
          selectedItemIds.remove(itemId);
        }
      }
      widget.toggleSelection?.call(itemId, isSelected ?? false);
    });
  }

  void toggleSelectAll(bool? value) {
    setState(() {
      if (value != null &&
          widget.toggleSelectAll != null &&
          widget.idExtractor != null) {
        if (value) {
          selectedItemIds.clear();
          widget.toggleSelectAll?.call(true);

          for (var item in widget.getItems(widget.provider)) {
            selectedItemIds.add(widget.idExtractor!(item));
          }
        } else {
          selectedItemIds.clear();
          widget.toggleSelectAll?.call(false);
        }
      }
    });
    // setState(() {});
  }

  bool _isAllSelected() {
    final items = widget.getItems(widget.provider);
    if (items.isEmpty || widget.isSelected == null) return false;
    for (var item in items) {
      if (!widget.isSelected!(item)) return false;
    }
    return true;
  }

  Widget _tableHeader(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final screenWidth = constraints.maxWidth;
      final orderedWidth = screenWidth * 0.12;
      final actionsWidth = screenWidth * 0.13;
      final contentWidth = screenWidth * 0.75;
      final itemWidth = contentWidth / widget.itemHeader.length;

      return Container(
        width: constraints.maxWidth,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 2, color: Color(darkGreyColor)),
            top: BorderSide(width: 2, color: Color(darkGreyColor)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: orderedWidth,
              child: Row(
                children: [
                  //blank space
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 20, right: 0, top: 12, bottom: 12),
                    child: SizedBox(
                      width: 24,
                    ),
                  ),
                  //checkbox
                  SizedBox(
                    width: 56,
                    child: Material(
                      color: const Color(whiteColor),
                      child: Checkbox(
                        activeColor: Colors.black,
                        side:
                            const BorderSide(color: Color(greyColor), width: 1),
                        value: _isAllSelected(),
                        onChanged: widget.toggleSelectAll != null
                            ? toggleSelectAll
                            : null,
                      ),
                    ),
                  ),
                  //blank
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
                ],
              ),
            ),
            SizedBox(
              width: contentWidth,
              child: Row(
                children: widget.itemHeader
                    .map(
                      (label) => SizedBox(
                        width: itemWidth,
                        child: Text(
                          label,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            if (widget.actionsBuilders != null &&
                widget.actionsBuilders!.isNotEmpty)
              SizedBox(
                width: actionsWidth,
                child: const Text(
                  actionKh,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
          ],
        ),
      );
    });
  }

  Widget _tableContent(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final orderedWidth = screenWidth * 0.12;
          final actionsWidth = screenWidth * 0.13;
          final contentWidth = screenWidth * 0.75;
          final itemWidth = contentWidth / widget.itemHeader.length;

          return ReorderableListView.builder(
            buildDefaultDragHandles: false,
            itemCount: _currentContent.length,
            itemBuilder: (context, index) {
              final item = _currentContent[index];
              final itemId = widget.idExtractor?.call(item);
              return Container(
                key: ValueKey(item),
                width: screenWidth,
                decoration: const BoxDecoration(
                  color: Color(whiteColor),
                  border: Border(
                    bottom: BorderSide(width: 1, color: Color(greyColor)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: orderedWidth,
                      child: Row(
                        children: [
                          //icon
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 0,
                              top: 12,
                              bottom: 12,
                            ),
                            child: ReorderableDragStartListener(
                              index: index,
                              child: const Icon(
                                Icons.drag_handle_rounded,
                                size: 24,
                                color: Color(greyColor),
                              ),
                            ),
                          ),
                          //check box
                          SizedBox(
                            width: 56,
                            child: Material(
                              color: const Color(whiteColor),
                              child: Checkbox(
                                activeColor: Colors.black,
                                side: const BorderSide(
                                    color: Color(greyColor), width: 1),
                                value:
                                    itemId != null && widget.isSelected != null
                                        ? widget.isSelected!(item)
                                        : false,
                                onChanged: itemId != null
                                    ? (isSelected) =>
                                        toggleRowSelection(itemId, isSelected)
                                    : null,
                              ),
                            ),
                          ),
                          //index
                          Container(
                            width: 58,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text('${index + 1}'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: contentWidth,
                      child: Row(
                        children: widget.columnExtractors
                            .map(
                              (extractor) => SizedBox(
                                width: itemWidth,
                                child: Text(extractor(item)),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    if (widget.actionsBuilders != null &&
                        widget.actionsBuilders!.isNotEmpty)
                      SizedBox(
                        width: actionsWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: widget.actionsBuilders!,
                        ),
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
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_tableHeader(context), _tableContent(context)],
    );
  }
}
