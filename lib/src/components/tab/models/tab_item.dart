import 'package:mude_core/core.dart';

class MudeTabItem {
  final String label;
  final MudeIconData? icon;
  final String? semanticsLabel;
  final String? semanticsHint;

  MudeTabItem({
    required this.label,
    this.icon,
    this.semanticsLabel,
    this.semanticsHint,
  });
}
