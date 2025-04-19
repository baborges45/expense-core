import 'package:expense_core/core.dart';

class CardFlags {
  static ExpenseFlagData? getCardFlag(String cardNumber) {
    if (cardNumber.startsWith('4')) {
      return ExpenseFlags.visa;
    } else if (cardNumber.startsWith('5')) {
      return ExpenseFlags.masterCard;
    } else if (cardNumber.startsWith('6')) {
      return ExpenseFlags.elo;
    } else {
      return null;
    }
  }
}
