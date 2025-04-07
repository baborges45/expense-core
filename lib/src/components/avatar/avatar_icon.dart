// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

import 'widgets/avatar_container_widget.dart';

class MudeAvatarIcon extends StatelessWidget {
  /// A [MudeAvatarSize] enum that define the avatar size.
  final MudeAvatarSize size;

  /// A [MudeIconData] object that provides an icon to the widge,
  /// you get all options in [MudeIcons].
  final MudeIconData? icon;

  /// A bool that if is true show a notification badge
  /// sinalizing new information.
  final bool showNotification;

  ///(Optional) A boolean parameter that specifies whether the link should have an inverse color scheme.
  ///The default value is false.
  final bool inverse;

  /// Set if you wants showing a image on this Avatar,
  /// set string locally or set a link from web.
  final String? source;

  /// A MudeAvatarSourceLoad enum that is used to set a new source load.
  /// you get all options in enum [MudeAvatarSourceLoad].
  late MudeAvatarSourceLoad? sourceLoad;

  ///A string value that indicates if you add more information from accessibility
  ///The default value is null
  final String? semanticsLabel;

  MudeAvatarIcon({
    super.key,
    this.icon,
    this.size = MudeAvatarSize.md,
    this.showNotification = false,
    this.inverse = false,
    this.source,
    this.sourceLoad,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var aliasTokens = tokens.alias;

    Color getIconColor() {
      return inverse
          ? aliasTokens.color.inverse.onIconColor
          : aliasTokens.color.elements.onIconColor;
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
          child: MudeIcon(
            icon: icon ?? MudeIcons.userLine,
            color: getIconColor(),
          ),
        ),
      ),
    );
  }
}
