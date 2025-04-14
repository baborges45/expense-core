import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';

import '../mixins/properties_mixin.dart';

class AlertDescription extends StatelessWidget with PropertiesMixin {
  final String description;
  final AlertHyperLink? hiperLink;
  final ExpenseAlertType type;

  const AlertDescription({
    super.key,
    required this.description,
    this.hiperLink,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    if (description.isEmpty) return const SizedBox.shrink();

    Color fontColor = getFontColor(
      context: context,
      alertColor: type,
    );

    Widget getHiperlink() {
      if (hiperLink == null) return const SizedBox.shrink();

      return Semantics(
        button: true,
        label: hiperLink!.text,
        child: GestureDetector(
          onTap: hiperLink!.onPressed,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: fontColor,
                ),
              ),
            ),
            child: ExpenseDescription(
              hiperLink!.text,
              color: fontColor,
            ),
          ),
        ),
      );
    }

    return Row(
      textBaseline: TextBaseline.alphabetic,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: [
        Flexible(
          child: ExpenseDescription(
            description,
            color: fontColor,
          ),
        ),
        getHiperlink(),
      ],
    );
  }
}
