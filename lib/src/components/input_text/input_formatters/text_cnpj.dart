import 'package:flutter/services.dart';

/// Formata o valor do campo com a mascara de CNPJ `99.999.999/9999-99`
class CNPJInputFormatter extends TextInputFormatter {
  // Define o tamanho máximo do campo.

  int get maxLength => 14;

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

    if (newValueLength >= 3) {
      newText.write('${newValue.text.substring(0, substrIndex = 2)}.');
      if (end >= 2) selectionIndex++;
    }
    if (newValueLength >= 6) {
      newText.write('${newValue.text.substring(2, substrIndex = 5)}.');
      if (end >= 5) selectionIndex++;
    }
    if (newValueLength >= 9) {
      newText.write('${newValue.text.substring(5, substrIndex = 8)}/');
      if (end >= 8) selectionIndex++;
    }
    if (newValueLength >= 13) {
      newText.write('${newValue.text.substring(8, substrIndex = 12)}-');
      if (end >= 12) selectionIndex++;
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
