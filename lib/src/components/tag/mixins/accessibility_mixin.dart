import 'package:expense_core/core.dart';

mixin AccessibilityMixin {
  String? getSemanticsLabel({
    required String? semanticsLabel,
    required String tag,
    required ExpenseTagStatus status,
  }) {
    final labelSemantics = semanticsLabel ?? tag;

    switch (status) {
      case ExpenseTagStatus.neutral:
        return labelSemantics;
      case ExpenseTagStatus.positive:
        return 'positivo: $labelSemantics';
      case ExpenseTagStatus.promote:
        return 'promoção: $labelSemantics';
      case ExpenseTagStatus.negative:
        return 'negativo: $labelSemantics';
      case ExpenseTagStatus.informative:
        return 'informativo: $labelSemantics';
      case ExpenseTagStatus.warning:
        return 'atenção: $labelSemantics';
    }
  }
}
