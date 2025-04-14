import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:expense_core/src/utils/check_url_is_valid.dart';

class ValidationLeadingType {
  ValidationLeadingType._();

  static Widget widgetAccept(dynamic widget, bool inverse) {
    if (widget is ExpenseIconData) {
      return ExpenseIcon(
        icon: widget,
        size: ExpenseIconSize.lg,
      );
    }

    if (widget is ExpenseImage) {
      var sourceLoad = urlIsvalid(widget.src) ? ExpenseImage.network : ExpenseImage.asset;

      return sourceLoad(
        widget.src,
        fit: widget.fit,
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

    if (widget is ExpenseAvatarGroup) {
      return ExpenseAvatarGroup(
        imageList: widget.imageList,
        size: ExpenseAvatarGroupSize.sm,
        isDescription: widget.isDescription,
      );
    }

    return const SizedBox.shrink();
  }
}
