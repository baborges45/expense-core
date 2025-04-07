import 'package:mude_core/core.dart';

mixin AccessibilityMixin {
  String? getSemanticsLabel({
    required String? semanticsLabel,
    required String tag,
    required MudeTagStatus status,
  }) {
    final labelSemantics = semanticsLabel ?? tag;

    switch (status) {
      case MudeTagStatus.neutral:
        return labelSemantics;
      case MudeTagStatus.positive:
        return 'positivo: $labelSemantics';
      case MudeTagStatus.promote:
        return 'promoção: $labelSemantics';
      case MudeTagStatus.negative:
        return 'negativo: $labelSemantics';
      case MudeTagStatus.informative:
        return 'informativo: $labelSemantics';
      case MudeTagStatus.warning:
        return 'atenção: $labelSemantics';
    }
  }
}
