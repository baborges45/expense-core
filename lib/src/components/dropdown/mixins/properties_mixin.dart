import 'package:flutter/material.dart';

import '../models/dropdown_item.dart';
import '../widgets/dropdown_select.dart';

mixin PropertiesMixin {
  openDrawer({
    required BuildContext context,
    required List<ExpenseDropdownItem> items,
    required Function(bool) updateState,
    required ValueChanged<ExpenseDropdownItem> onChanged,
    required ExpenseDropdownItem? value,
  }) {
    updateState(true);

    DropdownSelect.open(
      context: context,
      items: items,
      onInit: () => updateState(true),
      onChanged: (v) => onChanged(v),
      onFinish: () => updateState(false),
      value: value,
    );
  }
}
