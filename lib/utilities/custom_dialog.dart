import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:protocol_app/constants/color_constants.dart';

class CustomDialog {
  static bool _isDialogOpen = false;
  static void show({
    required BuildContext context,
    required Widget layout,
    required String title,
    Color backgroundColor = Colors.transparent,
  }) {
    _isDialogOpen = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        showDialog(
            context: context,
            barrierDismissible: false,
            barrierColor: backgroundColor,
            builder: (BuildContext context) {
              return PopScope(
                canPop: false,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                    child: Material(
                      color: Colors.transparent,
                      child: Scaffold(
                        appBar: PreferredSize(
                          preferredSize: const Size.fromHeight(80),
                          child: Container(
                            padding: const EdgeInsets.all(24.0),
                            decoration: BoxDecoration(
                              color: const Color(whiteColor),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(blackColor)
                                      .withAlpha((0.05 * 255).round()),
                                  spreadRadius: 0,
                                  blurRadius: 2,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                              border: const Border(
                                bottom: BorderSide(
                                    color: Color(0xFFE5E7EB),
                                    width: 1,
                                    strokeAlign: BorderSide.strokeAlignInside),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Text(
                                  title,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: Color(blackTextColor),
                                  ),
                                )),
                                IconButton(
                                  icon: const Icon(Icons.close,
                                      color: Colors.black),
                                  onPressed: () {
                                    cancel(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        body: Column(
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                color: const Color(whiteColor),
                                child: layout,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).then((value) {
          _isDialogOpen = false;
        });
      }
    });
  }

  static void cancel(BuildContext context) {
    if (_isDialogOpen) {
      Navigator.of(context, rootNavigator: true).pop();
      _isDialogOpen = false;
    }
  }
}
