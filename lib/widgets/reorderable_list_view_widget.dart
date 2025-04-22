import 'package:flutter/material.dart';
import 'package:protocol_app/constants/app_constants.dart';
import 'package:protocol_app/constants/color_constants.dart';
import 'package:protocol_app/constants/string_constants.dart';

class ReorderableListViewWidget extends StatefulWidget {
  const ReorderableListViewWidget({super.key});

  @override
  State<ReorderableListViewWidget> createState() =>
      _ReorderableListViewWidgetState();
}

class _ReorderableListViewWidgetState extends State<ReorderableListViewWidget> {
  late List<User> _users;

  @override
  void initState() {
    super.initState();
    _users = List.from(allUsers); // Create a mutable copy
  }

  Widget _buildTableHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
          ...tableHeader.map(
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
          const Text(
            actionKh,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableContent(BuildContext context) {
    return Expanded(
      child: ReorderableListView.builder(
        buildDefaultDragHandles: false,
        itemCount: _users.length,
        itemBuilder: (context, index) {
          return Container(
            key: ValueKey(_users[index]),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
                Expanded(child: Text(_users[index].name)),
                Expanded(child: Text(_users[index].position)),
                Expanded(child: Text(_users[index].joinAs)),
                const Icon(Icons.delete),
              ],
            ),
          );
        },
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (oldIndex < newIndex) newIndex -= 1;
            final item = _users.removeAt(oldIndex);
            _users.insert(newIndex, item);
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
        children: [
          _buildTableHeader(context),
          _buildTableContent(context),
        ],
      ),
    );
  }
}