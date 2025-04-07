import 'package:flutter/material.dart';
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

import 'widgets/content_widget.dart';

class MudeListSelectLine<T> extends StatelessWidget {
  ///A string that specifies the label of the widget.
  final String label;

  ///(Optional) A string that provides a description for the widget.
  final String? description;

  ///(Optional) A dynamic value that can be used to specify an icon or an image
  ///that will be displayed before the label.
  final dynamic leading;

  ///(Optional) An enum value of MudeListSelectType that specifies whether
  ///the widget is a checkbox or a radio button or a switch.
  final MudeListSelectType type;

  ///A generic type that represents the value of the widget.
  final T? value;

  ///A callback function that will be called when the value of the widget changes.
  final ValueChanged<T?> onChanged;

  ///(Optional) A boolean value that specifies whether the widget is disabled or not.
  final bool disabled;

  ///(Optional) A generic type that represents the group value of the widget. This parameter is used only when the widget is of type radio button.
  final T? groupValue;

  ///(Optional) An enum value of MudeListSelectPosition that specifies whether
  ///the showing line position.
  final MudeListSelectPosition linePosition;

  ///(Optional) A string parameter that represents a description for the Trailling in terms of accessibility
  final String? semanticsTrailling;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsDescription;

  const MudeListSelectLine({
    super.key,
    required this.label,
    required this.onChanged,
    required this.value,
    this.type = MudeListSelectType.checkbox,
    this.disabled = false,
    this.linePosition = MudeListSelectPosition.top,
    this.description,
    this.leading,
    this.groupValue,
    this.semanticsTrailling,
    this.semanticsLabel,
    this.semanticsDescription,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    Color getBorderColor() {
      return aliasTokens.color.elements.borderColor;
    }

    Border? getBorder() {
      if (linePosition == MudeListSelectPosition.top) {
        return Border(
          top: BorderSide(
            width: aliasTokens.defaultt.borderWidth,
            color: getBorderColor(),
          ),
        );
      }
      if (linePosition == MudeListSelectPosition.bottom) {
        return Border(
          bottom: BorderSide(
            width: aliasTokens.defaultt.borderWidth,
            color: getBorderColor(),
          ),
        );
      }

      return null;
    }

    return Semantics(
      container: true,
      child: Container(
        height: globalTokens.shapes.size.s11x,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: getBorder(),
        ),
        child: ContentWidget<T>(
          label: label,
          description: description,
          leading: leading,
          type: type,
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          disabled: disabled,
          semanticsTrailling: semanticsTrailling,
          semanticsDescription: semanticsDescription,
          semanticsLabel: semanticsLabel,
        ),
      ),
    );
  }
}
