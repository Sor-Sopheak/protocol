import 'package:flutter/material.dart';
import 'package:protocol_app/widgets/alert_widget.dart';
class OverlayService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static void showOverlayStatus(String message, {bool status = true}) {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    final overlay = Overlay.of(context, rootOverlay: true);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50,
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
        child: Material(
          color: Colors.transparent,
          child: AlertWidget(
            message: message,
            status: status,
            backButton: () {
              if (overlayEntry.mounted) overlayEntry.remove();
            },
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}
