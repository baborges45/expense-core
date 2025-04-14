import 'package:expense_core/core.dart';

class ExpenseBottomBarItem {
  /// Set a text to displayed on label
  final String label;

  /// Set icon [ExpenseIconData] to displayed
  final ExpenseIconData icon;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  ExpenseBottomBarItem({
    required this.label,
    required this.icon,
    this.semanticsLabel,
    this.semanticsHint,
  });
}
