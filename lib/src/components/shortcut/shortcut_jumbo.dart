import 'package:flutter/material.dart';
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

import 'widgets/container_widget.dart';

class MudeShortcutJumbo extends StatelessWidget {
  /// A String that represents the label of the shortcut.
  final String label;

  /// A String that represents the description of the shortcut.
  final String description;

  /// A [VoidCallback] that is called when the shortcut is pressed.
  final VoidCallback onPressed;

  ///(Optional) A [MudeIconData] that represents the icon for the shortcut.
  ///Used only if type is [MudeShortcutType.icon].
  final MudeIconData? icon;

  ///A boolean value that indicates whether the shortcut is disabled.
  ///The default value is false.
  final bool disabled;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  const MudeShortcutJumbo({
    super.key,
    required this.label,
    required this.description,
    required this.onPressed,
    this.icon,
    this.disabled = false,
    this.semanticsLabel,
    this.semanticsHint,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var aliasTokens = tokens.alias;

    Widget getItemShorcut() {
      Color iconColor = disabled
          ? aliasTokens.color.disabled.onIconColor
          : aliasTokens.color.elements.iconColor;

      return MudeIcon(
        icon: icon!,
        color: iconColor,
        size: MudeIconSize.lg,
      );
    }

    return Semantics(
      button: true,
      enabled: !disabled,
      label: semanticsLabel,
      hint: semanticsHint,
      excludeSemantics: semanticsHint != null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ContainerWidget(
            label: label,
            description: description,
            onPressed: onPressed,
            disabled: disabled,
            child: getItemShorcut(),
          ),
        ],
      ),
    );
  }
}
