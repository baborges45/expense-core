import 'package:expense_core/core.dart';

class TabItemModel {
  final String label;
  final ExpenseIconData? icon;
  final int index;
  final bool isScrollable;
  final String? semanticsLabel;
  final String? semanticsHint;

  TabItemModel({
    required this.label,
    required this.icon,
    required this.index,
    required this.isScrollable,
    this.semanticsLabel,
    this.semanticsHint,
  });
}
