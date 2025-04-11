import 'package:flutter/material.dart';

class TextTabButtonWidget extends StatelessWidget {
  final String text;
  final int index;
  final int activeIndex;
  final int? count;
  final Function(int) onPressed;

  const TextTabButtonWidget({
    super.key,
    required this.text,
    required this.index,
    required this.activeIndex,
    this.count,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    bool isActive = index == activeIndex;

    return TextButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
            isActive ? Colors.grey.shade200 : Colors.transparent),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
      ),
      onPressed: () => onPressed(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(
                color: isActive ? Colors.blue: Colors.black,
              ),
            ),
            if (count != null && count! > 0) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red.shade500,
                  border: Border.all(
                    color: Colors.red.shade600
                  ),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  count.toString(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
