// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:expense_core/src/utils/check_url_is_valid.dart';
import 'package:provider/provider.dart';

class AvatarContainerWidget extends StatelessWidget {
  final Widget child;
  final ExpenseAvatarSize size;
  final bool showNotification;
  final bool inverse;
  final String? source;
  final bool isAvatarBusiness;
  final Offset dotDistance;

  late ExpenseAvatarSourceLoad? sourceLoad;

  AvatarContainerWidget({
    super.key,
    required this.child,
    required this.size,
    this.showNotification = false,
    this.isAvatarBusiness = false,
    this.inverse = false,
    this.sourceLoad = ExpenseAvatarSourceLoad.asset,
    this.source,
    required this.dotDistance,
  }) {
    if (sourceLoad == null && source != null) {
      sourceLoad = urlIsvalid(source!) ? ExpenseAvatarSourceLoad.network : ExpenseAvatarSourceLoad.asset;
    }
  }

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    double getSizeAvatar() {
      switch (size) {
        case ExpenseAvatarSize.sm:
          return globalTokens.shapes.size.s3x;
        case ExpenseAvatarSize.md:
          return globalTokens.shapes.size.s6x;
        case ExpenseAvatarSize.lg:
          return globalTokens.shapes.size.s12x;
      }
    }

    double getBorderRadius() {
      if (!isAvatarBusiness) {
        return globalTokens.shapes.border.radiusCircular;
      }

      switch (size) {
        case ExpenseAvatarSize.sm:
          return globalTokens.shapes.border.radiusSm;
        case ExpenseAvatarSize.md:
          return globalTokens.shapes.border.radiusMd;
        case ExpenseAvatarSize.lg:
          return globalTokens.shapes.border.radiusLg;
      }
    }

    Color getBackgroundColor() {
      return inverse ? aliasTokens.color.inverse.bgColor : aliasTokens.color.elements.bgColor02;
    }

    final sizeAvatar = getSizeAvatar();

    return Stack(
      children: [
        Container(
          height: sizeAvatar,
          width: sizeAvatar,
          decoration: BoxDecoration(
            color: getBackgroundColor(),
            borderRadius: BorderRadius.circular(getBorderRadius()),
          ),
          child: child,
        ),
        _AvatarFilled(
          source: source,
          sourceLoad: sourceLoad,
          size: sizeAvatar,
          borderRadius: getBorderRadius(),
        ),
        _AvatarNotification(
          distance: dotDistance,
          size: size,
          show: showNotification,
        ),
      ],
    );
  }
}

class _AvatarFilled extends StatelessWidget {
  final String? source;
  final ExpenseAvatarSourceLoad? sourceLoad;
  final double size;
  final double borderRadius;

  const _AvatarFilled({
    required this.source,
    required this.sourceLoad,
    required this.size,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    if (source == null || source!.isEmpty) {
      return const SizedBox();
    }

    var sourceLoad = urlIsvalid(source!) ? ExpenseImage.network : ExpenseImage.asset;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: sourceLoad(
        source!,
        width: size,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _AvatarNotification extends StatelessWidget {
  final Offset distance;
  final ExpenseAvatarSize size;
  final bool show;

  const _AvatarNotification({
    required this.distance,
    required this.size,
    required this.show,
  });

  @override
  Widget build(BuildContext context) {
    if (!show) {
      return const SizedBox();
    }

    ExpenseBadgeSize getBadgeSize() {
      if (size == ExpenseAvatarSize.lg) {
        return ExpenseBadgeSize.lg;
      }

      return ExpenseBadgeSize.sm;
    }

    return Positioned(
      top: distance.dy,
      right: distance.dx,
      child: ExpenseBadge(
        size: getBadgeSize(),
      ),
    );
  }
}
