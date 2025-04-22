import 'package:flutter/material.dart';
import 'package:protocol_app/constants/color_constants.dart';

class DropDownButtonWidget extends StatefulWidget {
  final List<String> listOptions;
  final String iconPath;
  final double? iconWidth;
  final double? iconHeight;
  final Color? textColor;

  const DropDownButtonWidget({
    super.key,
    required this.listOptions,
    required this.iconPath,
    this.iconWidth = 16,
    this.iconHeight = 16,
    this.textColor,
  });

  @override
  State<DropDownButtonWidget> createState() => _DropDownButtonWidgetState();
}

class _DropDownButtonWidgetState extends State<DropDownButtonWidget> {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.listOptions.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(whiteColor),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: const Color(blackColor),
          width: 1,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
      ),
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: Image.asset(
          widget.iconPath,
          width: widget.iconWidth,
          height: widget.iconHeight,
        ),
        isDense: true,
        style: TextStyle(color: widget.textColor ?? const Color(blackColor)),
        dropdownColor: const Color(whiteColor),
        underline: const SizedBox.shrink(),
        onChanged: (String? value) {
          setState(() {
            dropdownValue = value!;
          });
        },
        items: widget.listOptions.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
