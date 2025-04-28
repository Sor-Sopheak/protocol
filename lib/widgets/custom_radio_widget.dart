import 'package:flutter/material.dart';
import 'package:protocol_app/constants/color_constants.dart';

class CustomRadioWidget extends StatefulWidget {
  final List<String> options;
  final String selectedOption;
  final ValueChanged<String> onChanged;
  final double size;
  final double borderWidth;
  final Color selectedColor;
  final Color unselectedColor;
  const CustomRadioWidget({
    super.key,
    required this.options,
    required this.selectedOption,
    required this.onChanged,
    this.size = 8.0,
    this.borderWidth = 1.0,
    this.selectedColor = const Color(blueColor),
    this.unselectedColor = const Color(greyColor),
  });

  @override
  State<CustomRadioWidget> createState() => _CustomRadioWidgetState();
}

class _CustomRadioWidgetState extends State<CustomRadioWidget> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: widget.options.map((option) {
        bool isSelected = widget.selectedOption == option;
        return GestureDetector(
          onTap: () {
            widget.onChanged(option);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? widget.selectedColor
                        : widget.unselectedColor,
                    width: widget.borderWidth,
                  ),
                ),
                child: Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        isSelected ? widget.selectedColor : Colors.transparent,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(option),
            ],
          ),
        );
      }).toList(),
    );
  }
}
