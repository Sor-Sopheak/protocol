import 'package:flutter/material.dart';
import 'package:protocol_app/constants/app_constants.dart';
import 'package:protocol_app/constants/color_constants.dart';
import 'package:protocol_app/widgets/drop_down_button_widget.dart';
import 'package:protocol_app/widgets/flat_button_widget.dart';
import 'package:protocol_app/widgets/search_widget.dart';
import 'package:protocol_app/widgets/table_widget.dart';
import 'package:protocol_app/widgets/text_button_widget.dart';

class HostEventTableWidget extends StatefulWidget {
  const HostEventTableWidget({super.key});

  @override
  State<HostEventTableWidget> createState() => _HostEventTableWidgetState();
}

class _HostEventTableWidgetState extends State<HostEventTableWidget> {
  final List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  String userSearchQuery = '';
  User? selectedUser;

  Widget _header(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: Color(whiteColor),
          border:
              Border(bottom: BorderSide(color: Color(greyColor), width: 1))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'តារាងស្នើសុំសមាសភាព',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF202020)),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              const SizedBox(width: 16),
              FlatButtonWidget(
                title: 'Export',
                btnAction: () {},
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                borderColor: const Color(blueColor),
                borderRadius: BorderRadius.circular(4),
                btnColor: const Color(whiteColor),
                textStyle: const TextStyle(
                  color: Color(blueColor),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 16),
              FlatButtonWidget(
                iconPath: 'assets/icons/send.png',
                title: 'Send Invitation',
                btnAction: () {},
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                borderRadius: BorderRadius.circular(4),
                btnColor: const Color(orangeColor),
                textStyle: const TextStyle(
                  color: Color(whiteColor),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 16),
              TextButtonWidget(
                isPrimary: true,
                btnAction: () {},
                iconPath: 'assets/icons/add_circle.png',
                btnTitle: 'Send Invitation',
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _subHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 2,
            child: Row(
              children: [
                FlatButtonWidget(
                  iconPath: 'assets/icons/delete_white.png',
                  title: 'Remove',
                  btnAction: () {},
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  borderRadius: BorderRadius.circular(4),
                  btnColor: const Color(redColor),
                  textStyle: const TextStyle(
                    color: Color(whiteColor),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 16),
                DropDownButtonWidget(
                  listOptions: list,
                  iconPath: 'assets/icons/arrow_drop_down.png',
                  iconWidth: 24,
                  iconHeight: 24,
                ),
                const SizedBox(width: 16),
                DropDownButtonWidget(
                  listOptions: list,
                  iconPath: 'assets/icons/page_info.png',
                ),
              ],
            ),
          ),
          //search
          Flexible(
            flex: 1,
            child: SearchWidget<User>(
              items: allUsers,
              hintText: "Search user...",
              searchIcon: true,
              onSearch: (query) {
                setState(() {
                  userSearchQuery = query;
                });
              },
              onItemSelected: (user) {
                setState(() {
                  selectedUser = user;
                });
              },
              onClear: () {
                setState(() {
                  selectedUser = null;
                  userSearchQuery = '';
                });
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _header(context),
        _subHeader(context),
        Container(
          // margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          color: const Color(whiteColor),
          child: TableWidget<User>(
            itemHeader: eventItems,
            itemContent: allUsers,
            columnExtractors: [
              (user) => user.name,
              (user) => user.position,
              (user) => user.joinAs,
            ],
            actionsBuilders: const [Icon(Icons.delete)],
            leadingCheckboxBuilder:
                const Checkbox(value: false, onChanged: null),
          ),
        )
      ],
    );
  }
}
