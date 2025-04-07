extension ExtensionsString on String {
  int onlyNumbers() {
    String numberString = replaceAll(RegExp(r'[^0-9]'), '');
    int result = int.parse(numberString);

    return result;
  }
}
