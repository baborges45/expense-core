import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:mude_core/core.dart';

class MudeNavControlDot extends StatelessWidget {
  ///An integer representing the number of items to be displayed in the row.
  final int length;

  ///An integer representing the index of the currently selected item.
  ///The default value is 0.
  final int indexSelected;

  ///A boolean value indicating whether the display should be inverted or not.
  ///The default value is false.
  final bool inverse;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  const MudeNavControlDot({
    super.key,
    required this.length,
    this.indexSelected = 0,
    this.inverse = false,
    this.semanticsLabel,
    this.semanticsHint,
  });

  @override
  Widget build(BuildContext context) {
    String autoHint = 'Item ${indexSelected + 1} de $length selecionado';

    return Semantics(
      label: semanticsLabel,
      hint: semanticsHint ?? autoHint,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...List.generate(
            length,
            (index) {
              return _MudeNav(
                active: index == indexSelected,
                inverse: inverse,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _MudeNav extends StatelessWidget {
  final bool active;
  final bool inverse;

  const _MudeNav({
    required this.inverse,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    var size = globalTokens.shapes.size;

    double getSizeDot() {
      return active ? size.s1x : size.half;
    }

    Color getBackgroundColor() {
      return active
          ? aliasTokens.color.selected.iconColor
          : aliasTokens.color.elements.bgColor05;
    }

    double sizes = getSizeDot();

    return SizedBox(
      width: size.s2x,
      height: size.s2x,
      child: Center(
        child: AnimatedContainer(
          duration: globalTokens.motions.durations.moderate02,
          width: sizes,
          height: sizes,
          decoration: BoxDecoration(
            color: getBackgroundColor(),
            borderRadius: BorderRadius.circular(
              globalTokens.shapes.border.radiusCircular,
            ),
          ),
        ),
      ),
    );
  }
}
