import 'package:flutter/material.dart';

class TextButtonToggleWidget extends StatefulWidget {
  final String? title;
  final String primaryTitle;
  final String secondaryTitle;
  final Function(bool) onToggle;

  const TextButtonToggleWidget({
    super.key,
    this.title,
    required this.primaryTitle,
    required this.secondaryTitle,
    required this.onToggle,
  });

  @override
  State<TextButtonToggleWidget> createState() => _TextButtonToggleWidgetState();
}

class _TextButtonToggleWidgetState extends State<TextButtonToggleWidget> {
  bool _isActivePrimary = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          Text(
            widget.title!,
            style: const TextStyle(
              color: Color(0xFF15163B),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
        ],
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFD6DAEB),
            borderRadius: BorderRadius.circular(5.0),
          ),
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              TextButton(
                style: ButtonStyle(
                  padding: WidgetStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(15.0)),
                  backgroundColor: WidgetStateProperty.all(_isActivePrimary
                      ? const Color(0xFF1C4076)
                      : Colors.transparent),
                  foregroundColor: WidgetStateProperty.all(_isActivePrimary
                      ? Colors.white
                      : const Color(0xFF15163B)),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _isActivePrimary = true;
                    widget.onToggle(true);
                  });
                },
                child: Text(
                  widget.primaryTitle,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  padding: WidgetStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(15.0)),
                  backgroundColor: WidgetStateProperty.all(!_isActivePrimary
                      ? const Color(0xFF1C4076)
                      : Colors.transparent),
                  foregroundColor: WidgetStateProperty.all(!_isActivePrimary
                      ? Colors.white
                      : const Color(0xFF15163B)),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _isActivePrimary = false;
                    widget.onToggle(false);
                  });
                },
                child: Text(
                  widget.secondaryTitle,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
