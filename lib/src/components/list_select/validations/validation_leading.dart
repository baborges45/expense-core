import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:expense_core/src/utils/check_url_is_valid.dart';

class ValidationLeadingType {
  // coverage:ignore-start
  const ValidationLeadingType._();
  // coverage:ignore-end

  static Widget widgetAccept(dynamic widget, bool inverse) {
    if (widget is ExpenseIconData) {
      return ExpenseIcon(
        icon: widget,
        size: ExpenseIconSize.lg,
      );
    }

    if (widget is ExpenseImage) {
      var sourcemap = urlIsvalid(widget.src) ? ExpenseImage.network : ExpenseImage.asset;

      return sourcemap(
        widget.src,
        fit: widget.fit,
        aspectRatio: ExpenseImageAspectRatio.ratio_1x1,
      );
    }

    if (widget is ExpenseAvatarIcon) {
      return ExpenseAvatarIcon(
        icon: widget.icon,
        source: widget.source,
        sourceLoad: widget.sourceLoad,
        showNotification: widget.showNotification,
        inverse: inverse,
        size: ExpenseAvatarSize.sm,
      );
    }

    if (widget is ExpenseCreditCard) {
      return ExpenseCreditCard(
        flag: widget.flag,
        inverse: inverse,
      );
    }

    return const SizedBox.shrink();
  }
}
