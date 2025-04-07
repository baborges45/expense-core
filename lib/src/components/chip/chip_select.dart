import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

import 'mixins/properties_mixin.dart';
import 'widgets/container_chip.dart';

class MudeChipSelect extends StatefulWidget {
  ///A boolean indicating whether the chip select is selected.
  ///The default value is false.
  final bool isSelected;

  ///A required string representing the label text to be displayed in the chip select.
  final String label;

  ///(Optional) An icon to be displayed before the label text.
  ///It uses the MudeIconData type from the mude_core package.
  final MudeIconData? icon;

  ///A required callback that will be called when the chip select is pressed.
  ///It takes a boolean parameter indicating the new selected state.
  final ValueChanged<bool> onPressed;

  ///(Optional) A boolean parameter that specifies whether the link should have an inverse color scheme.
  ///The default value is false.
  final bool inverse;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  const MudeChipSelect({
    super.key,
    this.icon,
    required this.onPressed,
    this.isSelected = false,
    required this.label,
    this.inverse = false,
    this.semanticsLabel,
    this.semanticsHint,
  });

  @override
  State<MudeChipSelect> createState() => _MudeChipSelectState();
}

class _MudeChipSelectState extends State<MudeChipSelect> with PropertiesMixin {
  bool isPressed = false;

  void _onPressedDown() {
    setState(() => isPressed = true);
  }

  void _onPressedUp() {
    setState(() => isPressed = false);
  }

  void _onPressed() {
    widget.onPressed(!widget.isSelected);

    SemanticsService.announce(
      !widget.isSelected ? 'Selecionado' : 'Não selecionado',
      TextDirection.ltr,
    );
  }

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var aliasTokens = tokens.alias;
    var globalsTokens = tokens.globals;

    Color getIconColor() {
      final isSelected = widget.isSelected;
      final aliasTokens = tokens.alias.color;

      return isSelected
          ? aliasTokens.selected.onIconColor
          : aliasTokens.elements.iconColor;
    }

    double getOpacity() {
      if (!widget.isSelected && isPressed) return 1;

      return isPressed ? aliasTokens.color.pressed.containerOpacity : 1;
    }

    TextStyle textStyle = getTextStyle(
      context: context,
      inverse: false,
      isSelected: widget.isSelected,
      type: MudeChipType.select,
    );

    Widget getIcon() {
      return widget.icon != null
          ? Row(children: [
              MudeIcon(
                icon: widget.icon!,
                size: MudeIconSize.sm,
                color: getIconColor(),
              ),
              SizedBox(width: globalsTokens.shapes.spacing.half, height: 0),
            ])
          : const SizedBox(width: 0, height: 0);
    }

    return Semantics(
      button: true,
      checked: widget.isSelected,
      label: widget.semanticsLabel,
      hint: widget.semanticsHint,
      child: GestureDetector(
        onTap: _onPressed,
        onTapDown: (e) => _onPressedDown(),
        onTapUp: (e) => _onPressedUp(),
        onTapCancel: () => setState(() => isPressed = false),
        child: Opacity(
          opacity: getOpacity(),
          child: ContainerChip(
            isPressed: isPressed,
            isSelected: widget.isSelected,
            type: MudeChipType.select,
            children: [
              getIcon(),
              Text(
                widget.label,
                style: textStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
