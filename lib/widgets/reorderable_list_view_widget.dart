import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:protocol_app/widgets/search_widget.dart';

final List<User> _allUsers = [
  User(name: 'Alice Smith', position: 'minister', joinAs: 'President'),
  User(
      name: 'Bob Johnson',
      position: 'secretaries of state',
      joinAs: 'Participants'),
  User(
      name: 'Charlie Brown',
      position: 'under secretaries of state',
      joinAs: 'Participants'),
  User(name: 'David Lee', position: 'deputy governor', joinAs: 'Participants'),
  User(
      name: 'Eve Wilson', position: 'director general', joinAs: 'Participants'),
  User(
      name: 'Fiona Green',
      position: 'director general',
      joinAs: 'Participants'),
  User(
      name: 'George Adams',
      position: 'deputy director general',
      joinAs: 'Participants'),
  User(
      name: 'Hannah Baker',
      position: 'senior official',
      joinAs: 'Participants'),
  User(name: 'Ian Carter', position: 'senior official', joinAs: 'Participants'),
  User(
      name: 'Jane Davis', position: 'director general', joinAs: 'Participants'),
];

final List<String> tableHeader = [
  'ល.រ', //index
  'នាម និង គោត្តនាម', // name
  'មុខតំណែង', //position
  'ចូលរួមជា', //joinas
  'សកម្មភាព', //action
];

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
    _users = List.from(_allUsers); // Create a mutable copy
  }

  Widget _buildHeaderRow(BuildContext context) {
    return Table(columnWidths: const {}, children: [
      TableRow(
        children: [
          const SizedBox.shrink(),
          const Material(
            color: Colors.transparent,
            child: Checkbox(
              activeColor: Colors.black,
              side: BorderSide(color: Colors.blue, width: 2),
              value: false,
              onChanged: null,
            ),
          ),
          ...tableHeader.map((label) {
            return Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }),
        ],
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Column(
        children: [
          _buildHeaderRow(context), // custom header
          Expanded(
            child: ReorderableListView.builder(
              buildDefaultDragHandles: false, //hide default right icon
              itemCount: _users.length,
              itemBuilder: (context, index) {
                return Row(
                  key: ValueKey(_users[index]),
                  children: [
                    ReorderableDragStartListener(
                      index: index,
                      child: const Icon(Icons.drag_handle),
                    ),
                    const Material(
                      color: Colors.transparent,
                      child: Checkbox(
                        activeColor: Colors.black,
                        side: BorderSide(color: Colors.blue, width: 2),
                        value: false,
                        onChanged: null,
                      ),
                    ),
                    Text('${index + 1}'),
                    Text(_users[index].name),
                    Text(_users[index].position),
                    Text(_users[index].joinAs),
                    const Icon(Icons.delete),
                  ],
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
          ),
        ],
      ),
    );
  }
}
