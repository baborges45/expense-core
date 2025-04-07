import 'package:mude_core/core.dart';

class MudeBottomBarItem {
  /// Set a text to displayed on label
  final String label;

  /// Set icon [MudeIconData] to displayed
  final MudeIconData icon;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  MudeBottomBarItem({
    required this.label,
    required this.icon,
    this.semanticsLabel,
    this.semanticsHint,
  });
}
