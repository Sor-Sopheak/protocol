import 'package:flutter/material.dart';
import 'package:protocol_app/constants/color_constants.dart';

class AlertWidget extends StatelessWidget {
  final String message;
  final bool status;
  final VoidCallback? backButton;
  const AlertWidget({
    super.key,
    required this.message,
    this.status = false,
    this.backButton,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color:
            status ? const Color(greenColor) : const Color(redColor),
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: status
                  ? const Color(greenColor)
                  : const Color(redColor),
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: ClipOval(
                  child: Image.asset(
                    status
                        ? 'assets/icons/success.png'
                        : 'assets/icons/x_fail.png',
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  message,
                  style: TextStyle(
                    color: status
                        ? const Color(greenColor)
                        : const Color(redColor),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: backButton,
              child: ImageIcon(
                const AssetImage('assets/icons/close_success_icon.png'),
                size: 20,
                color: status
                    ? const Color(greenColor)
                    : const Color(redColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
