import 'package:flutter/services.dart';

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final inputData = newValue.text;
    final buffer = StringBuffer();

    for (var i = 0; i < inputData.length; i++) {
      buffer.write(inputData[i]);

      if ((i + 1) % 4 == 0 && (i + 1) != inputData.length) {
        buffer.write(' '); // double space
      }
    }

    final bufferString = buffer.toString();

    return TextEditingValue(
      text: bufferString,
      selection: TextSelection.collapsed(offset: bufferString.length),
    );
  }
}
