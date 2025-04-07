import 'package:flutter/material.dart';
import 'package:mude_core/core.dart';
import 'package:mude_core/src/utils/check_url_is_valid.dart';

class ValidationLeadingType {
  // coverage:ignore-start
  const ValidationLeadingType._();
  // coverage:ignore-end

  static Widget widgetAccept(dynamic widget, bool inverse) {
    if (widget is MudeIconData) {
      return MudeIcon(
        icon: widget,
        size: MudeIconSize.lg,
      );
    }

    if (widget is MudeImage) {
      var sourceLoad =
          urlIsvalid(widget.src) ? MudeImage.network : MudeImage.asset;

      return sourceLoad(
        widget.src,
        fit: widget.fit,
      );
    }

    if (widget is MudeAvatarIcon) {
      return MudeAvatarIcon(
        icon: widget.icon,
        source: widget.source,
        sourceLoad: widget.sourceLoad,
        showNotification: widget.showNotification,
        inverse: inverse,
        size: MudeAvatarSize.md,
      );
    }

    if (widget is MudeCreditCard) {
      return MudeCreditCard(
        flag: widget.flag,
        inverse: inverse,
      );
    }

    if (widget is MudeAvatarGroup) {
      return MudeAvatarGroup(
        imageList: widget.imageList,
        size: MudeAvatarGroupSize.sm,
        isDescription: widget.isDescription,
      );
    }

    return const SizedBox.shrink();
  }
}
