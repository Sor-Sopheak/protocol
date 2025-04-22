import 'package:flutter/material.dart';
import 'package:protocol_app/constants/color_constants.dart';

class TextButtonWidget extends StatefulWidget {
  final VoidCallback btnAction;
  final String btnTitle;
  final bool? isPrimary;
  final String? iconPath;
  final Color? primaryBtnColor;
  final Color? secondaryBtnColor;
  final Color? titleColor;
  final double? height;
  final double? iconWidth;
  final double? iconHeight;
  const TextButtonWidget({
    super.key,
    required this.btnAction,
    required this.btnTitle,
    this.isPrimary = true,
    this.iconPath,
    this.primaryBtnColor,
    this.secondaryBtnColor,
    this.titleColor,
    this.height = 48, 
    this.iconWidth = 16, 
    this.iconHeight = 16,
  });

  @override
  State<TextButtonWidget> createState() => _TextButtonWidgetState();
}

class _TextButtonWidgetState extends State<TextButtonWidget> {
  late Color _currentBtnColor;

  @override
  void initState() {
    super.initState();
    _currentBtnColor = widget.primaryBtnColor ?? const Color(blueColor);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) => setState(() {
        _currentBtnColor = widget.secondaryBtnColor ?? const Color(orangeColor);
      }),
      onExit: (event) => setState(() {
        _currentBtnColor = widget.primaryBtnColor ?? const Color(blueColor);
      }),
      child: GestureDetector(
        onTap: widget.btnAction,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          height: widget.height,
          decoration: BoxDecoration(
              color: _currentBtnColor,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: _currentBtnColor,
                width: 1,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(blackColor).withAlpha((0.1 * 255).round()),
                  spreadRadius: 0,
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
                BoxShadow(
                  color: const Color(blackColor).withAlpha((0.6 * 255).round()),
                  spreadRadius: 0,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.iconPath != null) ...[
                Image.asset(
                  widget.iconPath!,
                  width: widget.iconWidth,
                  height: widget.iconHeight,
                ),
                const SizedBox(width: 5),
              ],
              Text(
                widget.btnTitle,
                style: TextStyle(
                  color: widget.titleColor ??
                      (widget.isPrimary == true
                          ? Colors.white
                          : widget.isPrimary == false
                              ? Colors.black
                              : null),
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
