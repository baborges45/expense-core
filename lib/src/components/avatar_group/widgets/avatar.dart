// ignore_for_file: must_be_immutable, deprecated_member_use, unused_element

part of '../avatar_group.dart';

class _AvatarIcon extends StatelessWidget {
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

  /// A [String] representing the text value,
  final String? text;

  _AvatarIcon({
    super.key,
    this.icon,
    this.size = ExpenseAvatarSize.md,
    this.showNotification = false,
    this.inverse = false,
    this.source,
    this.sourceLoad,
    this.semanticsLabel,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    double getSizeIcon() {
      switch (size) {
        case ExpenseAvatarSize.sm:
          return globalTokens.shapes.size.s1x;
        case ExpenseAvatarSize.md:
          return globalTokens.shapes.size.s2x;
        case ExpenseAvatarSize.lg:
          return globalTokens.shapes.size.s3x;
      }
    }

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
          child: _Icon(
            icon: icon ?? ExpenseIcons.userLine,
            size: getSizeIcon(),
            color: getIconColor(),
          ),
        ),
      ),
    );
  }
}
