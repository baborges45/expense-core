import 'package:expense_core/core.dart';

class ExpenseBottomBarFloatItem {
  /// Set a text to displayed on label
  final String label;

  /// Set a icon [ExpenseIconData] to displayed
  final ExpenseIconData icon;

  /// Set true if displayed a symbol notification
  final bool showNotification;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  ExpenseBottomBarFloatItem({
    required this.label,
    required this.icon,
    this.showNotification = false,
    this.semanticsLabel,
    this.semanticsHint,
  });
}
