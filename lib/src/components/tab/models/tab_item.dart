import 'package:expense_core/core.dart';

class ExpenseTabItem {
  final String label;
  final ExpenseIconData? icon;
  final String? semanticsLabel;
  final String? semanticsHint;

  ExpenseTabItem({
    required this.label,
    this.icon,
    this.semanticsLabel,
    this.semanticsHint,
  });
}
