import 'package:flutter/material.dart';
import 'package:protocol_app/constants/color_constants.dart';

abstract class Searchable {
  String get displayValue;
  bool matches(String query);
}

class SearchWidget<T extends Searchable> extends StatefulWidget {
  final List<T> items;
  final String hintText;
  final bool? searchIcon;
  final Function(String) onSearch;
  final Function(T) onItemSelected;
  final VoidCallback onClear;

  const SearchWidget({
    super.key,
    required this.items,
    required this.hintText,
    this.searchIcon,
    required this.onSearch,
    required this.onItemSelected,
    required this.onClear,
  });

  @override
  State<SearchWidget<T>> createState() => _SearchWidgetState<T>();
}

class _SearchWidgetState<T extends Searchable> extends State<SearchWidget<T>> {
  final GlobalKey _textFieldKey = GlobalKey();
  late TextEditingController searchController;
  late FocusNode focusNode;
  late List<T> filteredItems;
  OverlayEntry? _overlayEntry;
  bool showNoResults = false;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    focusNode = FocusNode();
    filteredItems = widget.items;

    focusNode.addListener(() {
      setState(() {});
      if (focusNode.hasFocus) {
        _filterSearchResults(searchController.text);
        _showOverlay();
      } else {
        Future.delayed(const Duration(milliseconds: 200), () {
          _removeOverlay();
        });
      }
    });
  }

  void _filterSearchResults(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredItems = widget.items;
        showNoResults = false;
      } else {
        filteredItems =
            widget.items.where((item) => item.matches(query)).toList();
        showNoResults = filteredItems.isEmpty;
      }
    });

    widget.onSearch(query);
    _showOverlay();
  }

  void _showOverlay() {
    _removeOverlay();

    final RenderBox renderBox =
        _textFieldKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy - 127,
        width: renderBox.size.width,
        child: Material(
          elevation: 4.0,
          child: filteredItems.isNotEmpty
              ? Container(
                  constraints: const BoxConstraints(maxHeight: 200),
                  decoration: BoxDecoration(
                    color: const Color(whiteColor),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF121A2B).withOpacity(0.1),
                        offset: const Offset(0, 20),
                        blurRadius: 25.0,
                        spreadRadius: -4.0,
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return Container(
                        alignment: Alignment.centerLeft,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Color(greyColor)),
                            left: BorderSide(color: Color(greyColor)),
                            right: BorderSide(color: Color(darkGreyColor)),
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            searchController.text = item.displayValue;
                            widget.onItemSelected(item);
                            _removeOverlay();
                            focusNode.unfocus();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item.displayValue,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(blueColor),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text("No data"),
                ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

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
      key: _textFieldKey,
      controller: searchController,
      focusNode: focusNode,
      cursorColor: const Color(blueColor),
      cursorWidth: 1,
      cursorErrorColor: const Color(redColor),
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.searchIcon == true ? const Icon(Icons.search) : null,
        suffixIcon: searchController.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  searchController.clear();
                  filteredItems.clear();
                  widget.onClear();
                  _filterSearchResults('');
                  _removeOverlay();
                },
              )
            : null,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(greyColor),
            width: 1,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(blueColor),
            width: 1,
          ),
        ),
      ),
      onChanged: _filterSearchResults,
      onTap: () {
        if (!focusNode.hasFocus) {
          focusNode.requestFocus();
        } else if (filteredItems.isNotEmpty && _overlayEntry == null) {
          _showOverlay();
        } else if (filteredItems.isEmpty && _overlayEntry == null) {
          _showOverlay();
        }
      },
    );
  }
}
