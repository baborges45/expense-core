import 'package:mude_core/core.dart';

class CardFlags {
  static MudeFlagData? getCardFlag(String cardNumber) {
    if (cardNumber.startsWith('4')) {
      return MudeFlags.visa;
    } else if (cardNumber.startsWith('5')) {
      return MudeFlags.masterCard;
    } else if (cardNumber.startsWith('6')) {
      return MudeFlags.elo;
    } else {
      return null;
    }
  }
}
