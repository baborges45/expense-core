// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

import 'widgets/avatar_container_widget.dart';

class ExpenseAvatarIcon extends StatelessWidget {
  /// A [ExpenseAvatarSize] enum that define the avatar size.
  final ExpenseAvatarSize size;

  /// A [ExpenseIconData] object that provides an icon to the widge,
  /// you get all options in [ExpenseIcons].
  final ExpenseIconData? icon;

  /// A bool that if is true show a notification badge
  /// sinalizing new information.
  final bool showNotification;

  ///(Optional) A boolean parameter that specifies whether the link should have an inverse color scheme.
  ///The default value is false.
  final bool inverse;

  /// Set if you wants showing a image on this Avatar,
  /// set string locally or set a link from web.
  final String? source;

  /// A ExpenseAvatarSourceLoad enum that is used to set a new source load.
  /// you get all options in enum [ExpenseAvatarSourceLoad].
  late ExpenseAvatarSourceLoad? sourceLoad;

  ///A string value that indicates if you add more information from accessibility
  ///The default value is null
  final String? semanticsLabel;

  ExpenseAvatarIcon({
    super.key,
    this.icon,
    this.size = ExpenseAvatarSize.md,
    this.showNotification = false,
    this.inverse = false,
    this.source,
    this.sourceLoad,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var aliasTokens = tokens.alias;

    Color getIconColor() {
      return inverse ? aliasTokens.color.inverse.onIconColor : aliasTokens.color.elements.onIconColor;
    }

    Offset getDotDistance() {
      return const Offset(4, 4);
    }

    return Semantics(
      label: semanticsLabel,
      image: true,
      child: AvatarContainerWidget(
        size: size,
        showNotification: showNotification,
        source: source,
        sourceLoad: sourceLoad,
        inverse: inverse,
        dotDistance: getDotDistance(),
        child: Center(
          child: ExpenseIcon(
            icon: icon ?? ExpenseIcons.userLine,
            color: getIconColor(),
          ),
        ),
      ),
    );
  }
}
