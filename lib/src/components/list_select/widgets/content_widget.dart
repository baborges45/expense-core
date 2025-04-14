import 'package:expense_core/src/components/list_select/widgets/trailing_widget.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:expense_core/core.dart';

import 'label_widget.dart';
import 'description_widget.dart';
import 'leading_widget.dart';

class ContentWidget<T> extends StatelessWidget {
  final String label;
  final String? description;
  final dynamic leading;
  final ExpenseListSelectType type;
  final T? value;
  final ValueChanged<T?> onChanged;
  final bool disabled;
  final T? groupValue;
  final bool inverse;
  final String? semanticsTrailling;
  final String? semanticsLabel;
  final String? semanticsDescription;

  const ContentWidget({
    super.key,
    required this.label,
    this.description,
    this.leading,
    this.type = ExpenseListSelectType.checkbox,
    required this.onChanged,
    required this.value,
    this.groupValue,
    this.disabled = false,
    this.inverse = false,
    this.semanticsTrailling,
    this.semanticsLabel,
    this.semanticsDescription,
  });

  @override
  Widget build(BuildContext context) {
    var globalTokens = Provider.of<ExpenseThemeManager>(context).globals;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Leading
        LeadingWidget(
          child: leading,
          inverse: inverse,
        ),

        // Label - Description
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LabelWidget(
                label: label,
                semanticsLabel: semanticsLabel,
              ),
              if (description != null && description!.isNotEmpty) SizedBox(height: globalTokens.shapes.spacing.half),
              DescriptionWidget(
                description: description,
                semanticsDescription: semanticsDescription,
              ),
            ],
          ),
        ),

        // Trailing Option
        TrailingWidget<T>(
          type: type,
          value: value,
          onChanged: onChanged,
          disabled: disabled,
          groupValue: groupValue,
          semanticsTrailling: semanticsTrailling,
        ),
      ],
    );
  }
}
