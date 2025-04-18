import 'package:flutter/material.dart';
import 'package:protocol_app/widgets/general_card_widget.dart';
import 'package:protocol_app/widgets/reorderable_list_view_widget.dart';
import 'package:protocol_app/widgets/search_widget.dart';
import 'package:protocol_app/widgets/text_button_toggle_widget.dart';

class TodayEventContent extends StatefulWidget {
  const TodayEventContent({super.key});

  @override
  State<TodayEventContent> createState() => _TodayEventContentState();
}

class _TodayEventContentState extends State<TodayEventContent> {
  bool _isConfidential = true;
final List<User> _allUsers = [
  User(name: 'Alice Smith', position: 'minister', joinAs: 'President'),
  User(name: 'Bob Johnson', position: 'secretaries of state', joinAs: 'Participants'),
  User(name: 'Charlie Brown', position: 'under secretaries of state', joinAs: 'Participants'),
  User(name: 'David Lee', position: 'deputy governor', joinAs: 'Participants'),
  User(name: 'Eve Wilson', position: 'director general', joinAs: 'Participants'),
  User(name: 'Fiona Green', position: 'director general', joinAs: 'Participants'),
  User(name: 'George Adams', position: 'deputy director general', joinAs: 'Participants'),
  User(name: 'Hannah Baker', position: 'senior official', joinAs: 'Participants'),
  User(name: 'Ian Carter', position: 'senior official', joinAs: 'Participants'),
  User(name: 'Jane Davis', position: 'director general', joinAs: 'Participants'),
];

  final List<User> _selectedUsers = [];
  void _handleSearch(String query) {
    print('Searching for: $query');
  }

  void _handleItemSelected(User user) {
    print('**_handleItemSelectedInContent CALLED with user: ${user.name}**');
    setState(() {
      if (!_selectedUsers.contains(user)) {
        _selectedUsers.add(user);
        // _updateDraggableList();
        print('Selected user in Content: ${user.name}');
        print('Current _selectedUsers: $_selectedUsers');
      }
    });
  }

  void _handleClearSearch() {
    print('Search cleared');
    setState(() {
      _selectedUsers.clear();
      // _updateDraggableList();
    });
  }

  void _handleRemoveSelected(User user) {
    setState(() {
      _selectedUsers.remove(user);
      // _updateDraggableList();
      print('Removed user: ${user.name}');
    });
  }

  String _userToString(User user) => user.name;
  String _userFieldToCheck(User user) => user.name.toLowerCase();

  void _handleConfidentialityToggle(bool isPrimaryActive) {
    setState(() {
      _isConfidential = isPrimaryActive;
      print('Confidentiality: $_isConfidential');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  TextButtonToggleWidget(
                    title: 'Confidentiality',
                    primaryTitle: 'Confidential',
                    secondaryTitle: 'Non-confidential',
                    onToggle: _handleConfidentialityToggle,
                  ),
                  const SizedBox(width: 12),
                  TextButtonToggleWidget(
                    title: 'Priority',
                    primaryTitle: 'In Urgent',
                    secondaryTitle: 'Normal',
                    onToggle: _handleConfidentialityToggle,
                  ),
                  const SizedBox(width: 12),
                ],
              ),
              SizedBox(
                width: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchWidget<User>(
                      items: _allUsers,
                      hintText: 'Search Users by Name',
                      searchIcon: true,
                      onSearch: _handleSearch,
                      onItemSelected: _handleItemSelected,
                      onClear: _handleClearSearch,
                      itemAsString: _userToString,
                      fieldToCheck: _userFieldToCheck,
                    ),
                    Wrap(
                      spacing: 8.0,
                      children: _selectedUsers
                          .map(
                            (user) => Chip(
                              label: Text(user.name),
                              onDeleted: () => _handleRemoveSelected(user),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: 1,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 24.0),
            itemBuilder: (BuildContext context, int index) {
              return const GeneralCardWidget();
            },
          ),
          // const DragHandleExample(),
          ReorderableListViewWidget()
        ],
      ),
    );
  }
}
