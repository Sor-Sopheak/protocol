import 'package:flutter/material.dart';

class User {
  final String name;
  final String position;
  final String joinAs;
  User({required this.name, required this.position, required this.joinAs});
}

class SearchWidget<T> extends StatefulWidget {
  final List<T> items;
  final String hintText;
  final bool? searchIcon;
  final Function(String) onSearch;
  final Function(T) onItemSelected;
  final VoidCallback onClear;
  final String Function(T) itemAsString;
  final String Function(T) fieldToCheck;

  const SearchWidget({
    super.key,
    required this.items,
    required this.hintText,
    this.searchIcon,
    required this.onSearch,
    required this.onItemSelected,
    required this.onClear,
    required this.itemAsString,
    required this.fieldToCheck,
  });

  @override
  State<SearchWidget<T>> createState() => _SearchWidgetState<T>();
}

class _SearchWidgetState<T> extends State<SearchWidget<T>> {
  late final TextEditingController searchController;
  late final FocusNode focusNode;
  OverlayEntry? _overlayEntry;
  List<T> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    focusNode = FocusNode();
    focusNode.addListener(_handleFocusChange);
    searchController.addListener(_handleSearchChanged);
    _filteredItems = List.from(widget.items);
  }

  void _handleFocusChange() {
    if (focusNode.hasFocus) {
      _showOverlay();
    } else {
      _removeOverlay();
    }
  }

  void _handleSearchChanged() {
    final query = searchController.text.toLowerCase();
    _filteredItems = widget.items.where((item) {
      final field = widget.fieldToCheck(item).toLowerCase();
      return field.contains(query);
    }).toList();

    widget.onSearch(query);
    _rebuildOverlay();
  }

  void _showOverlay() {
    _removeOverlay();

    OverlayState? overlayState = Overlay.of(context);
    RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      Offset offset = renderBox.localToGlobal(Offset.zero);

      _overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          left: offset.dx,
          top: offset.dy + renderBox.size.height,
          width: renderBox.size.width,
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(8),
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                final item = _filteredItems[index];
                return InkWell(
                  onTap: () {
                    print(
                        '**InkWell TAPPED for item: ${widget.itemAsString(item)}**');
                    widget.onItemSelected(item);
                    searchController.clear();
                    _removeOverlay();
                    focusNode.unfocus();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.itemAsString(item)),
                  ),
                );
              },
            ),
          ),
        ),
      );
      overlayState.insert(_overlayEntry!);
    }
  }

  void _rebuildOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.markNeedsBuild();
    } else if (focusNode.hasFocus) {
      _showOverlay();
    }
  }

  String fieldToCheck(T item) => widget.fieldToCheck(item);

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    searchController.dispose();
    focusNode.dispose();
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.searchIcon == true ? const Icon(Icons.search) : null,
        suffixIcon: searchController.text.isNotEmpty && focusNode.hasFocus
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  searchController.clear();
                  widget.onClear();
                  _handleSearchChanged();
                },
              )
            : null,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
