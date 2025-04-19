import 'package:flutter/material.dart';
import 'types/type.dart';
import 'widgets/toast_animated.dart';
import 'widgets/toast_widget.dart';

class ExpenseToastColoful {
  static void show({
    ///A BuildContext object representing the current context.
    required BuildContext context,

    ///A string object representing the message to display in the toast notification.
    required String message,

    ///(Optional) A [ExpenseToastType] object representing the type of the toast notification .
    ExpenseToastType? type,

    ///A [Duration] object representing the duration of the toast notification.
    ///The default value is 4 seconds.
    Duration duration = const Duration(seconds: 4),

    ///A string value that indicates additional accessibility information.
    ///The default value is null
    final String? semanticsHint,
  }) {
    OverlayEntry? overlayEntry;

    void onDismissed() {
      if (overlayEntry != null) {
        overlayEntry!.remove();
        overlayEntry = null;
      }
    }

    ExpenseToastColor getColor() {
      return type == ExpenseToastType.negative ? ExpenseToastColor.negative : ExpenseToastColor.positive;
    }

    overlayEntry = OverlayEntry(
      builder: (context) => ToastAnimated(
        onDismissed: onDismissed,
        duration: duration,
        child: ExpenseToastWidget(
          message: message,
          type: type,
          color: getColor(),
          semanticsHint: semanticsHint,
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry!);
  }
}
