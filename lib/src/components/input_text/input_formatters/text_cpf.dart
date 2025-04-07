import 'package:flutter/services.dart';

/// Formata o valor do campo com a mascara de CPF: `XXX.XXX.XXX-XX`
class CPFInputFormatter extends TextInputFormatter {
  // Define o tamanho máximo do campo.
  int get maxLength => 11;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newValueLength = newValue.text.length;

    if (newValueLength > maxLength) {
      return oldValue;
    }

    final end = newValue.selection.end;

    var selectionIndex = end;
    var substrIndex = 0;
    final newText = StringBuffer();

    if (newValueLength >= 4) {
      newText.write('${newValue.text.substring(0, substrIndex = 3)}.');
      if (end >= 3) selectionIndex++;
    }
    if (newValueLength >= 7) {
      newText.write('${newValue.text.substring(3, substrIndex = 6)}.');
      if (end >= 6) selectionIndex++;
    }
    if (newValueLength >= 10) {
      newText.write('${newValue.text.substring(6, substrIndex = 9)}-');
      if (end >= 9) selectionIndex++;
    }
    if (newValueLength >= substrIndex) {
      newText.write(newValue.text.substring(substrIndex));
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
