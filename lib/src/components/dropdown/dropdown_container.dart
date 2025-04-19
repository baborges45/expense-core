import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

import 'mixins/properties_mixin.dart';
import 'widgets/dropdown_icon.dart';

class ExpenseDropDownContainer extends StatefulWidget {
  ///A list of [ExpenseDropdownItem] objects that represent the dropdown items.
  final List<ExpenseDropdownItem> items;

  ///A callback function that will be called when the dropdown value is changed.
  final ValueChanged<ExpenseDropdownItem> onChanged;

  ///The currently selected dropdown item.
  final ExpenseDropdownItem? value;

  ///A string that represents the placeholder text to display when no item is selected.
  final String placeholder;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  ///A [ExpenseDropDownType] object representing the type of the dropdown.
  final ExpenseDropDownType type;

  ///(Optional) A boolean parameter that specifies whether the link should have an inverse color scheme.
  ///The default value is false.
  final bool inverse;

  const ExpenseDropDownContainer({
    super.key,
    required this.items,
    required this.onChanged,
    this.placeholder = 'Selecione um item',
    this.value,
    this.semanticsLabel,
    this.semanticsHint,
    this.type = ExpenseDropDownType.container,
    this.inverse = false,
  });

  @override
  State<ExpenseDropDownContainer> createState() => _ExpenseDropDownState();
}

class _ExpenseDropDownState extends State<ExpenseDropDownContainer> with PropertiesMixin {
  bool _isOpen = false;
  bool _isPressed = false;

  void updateState(bool v) {
    setState(
      () {
        _isOpen = v;
        _isPressed = v;
      },
    );
  }

  void _onPressed() {
    openDrawer(
      context: context,
      items: widget.items,
      updateState: updateState,
      onChanged: (v) => widget.onChanged(v),
      value: widget.value,
    );
  }

  double _calculateWidth(String text) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    return textPainter.size.width;
  }

  @override
  Widget build(BuildContext context) {
    final tokens = Provider.of<ExpenseThemeManager>(context);
    final globalTokens = tokens.globals;
    final aliasTokens = tokens.alias;
    final spacing = globalTokens.shapes.spacing;
    final size = globalTokens.shapes.size;
    final border = globalTokens.shapes.border;
    final textColor = aliasTokens.color;

    String getPlaceholder() {
      return widget.value != null ? widget.value!.label : widget.placeholder;
    }

    double getOpacity() {
      return _isOpen ? globalTokens.shapes.opacity.superHigh : 1;
    }

    Color getPressedColor() {
      return widget.inverse ? aliasTokens.mixin.pressedOutlineInverse : aliasTokens.mixin.pressedOutline;
    }

    Widget getText() {
      if (widget.inverse) {
        return Text(
          getPlaceholder(),
          style: aliasTokens.mixin.labelMd2.merge(
            TextStyle(
              color: textColor.inverse.labelColor,
            ),
          ),
        );
      }

      return Text(
        getPlaceholder(),
        style: aliasTokens.mixin.labelMd2.merge(
          TextStyle(
            color: textColor.text.labelColor,
          ),
        ),
      );
    }

    Widget text = getText();

    Widget onPressAnimation() {
      var size = globalTokens.shapes.size;

      return _isPressed
          ? Container(
              key: const Key('dropDown.animation'),
              height: size.s3x + spacing.s2x,
              width: _calculateWidth(getPlaceholder()) + spacing.s6x,
              decoration: BoxDecoration(
                color: getPressedColor(),
                borderRadius: BorderRadius.circular(
                  globalTokens.shapes.border.radiusSm,
                ),
              ),
            )
          : const SizedBox(height: 0, width: 0);
    }

    return Semantics(
      button: true,
      selected: widget.value != null,
      label: widget.semanticsLabel,
      hint: widget.semanticsHint,
      child: Opacity(
        opacity: getOpacity(),
        child: GestureDetector(
          onTap: _onPressed,
          onTapDown: (e) => updateState(true),
          onTapUp: (e) => updateState(false),
          onTapCancel: () => updateState(false),
          child: Container(
            color: Colors.transparent,
            child: widget.type == ExpenseDropDownType.ghost
                ? Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.centerLeft,
                    children: [
                      //
                      // Pressed
                      onPressAnimation(),
                      Container(
                        height: size.s6x,
                        padding: EdgeInsets.symmetric(horizontal: spacing.s1x),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Text
                            text,
                            // Icon
                            SizedBox(width: spacing.s1x),
                            DropdownIcon(
                              isOpen: _isOpen,
                              inverse: widget.inverse,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Container(
                    height: size.s6x,
                    padding: EdgeInsets.symmetric(horizontal: spacing.s2x),
                    decoration: BoxDecoration(
                      color: aliasTokens.color.elements.bgColor02,
                      borderRadius: BorderRadius.circular(
                        border.radiusCircular,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Text
                        text,
                        // Icon
                        SizedBox(width: spacing.s1x),
                        DropdownIcon(isOpen: _isOpen),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
