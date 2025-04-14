import 'package:flutter/material.dart';

import 'package:expense_core/core.dart';

class DropdownSelect {
  static open({
    required BuildContext context,
    required List<ExpenseDropdownItem> items,
    required VoidCallback onInit,
    required ValueChanged<ExpenseDropdownItem> onChanged,
    required VoidCallback onFinish,
    final ExpenseDropdownItem? value,
  }) async {
    await ExpenseDrawer.show(
      context,
      maxHeight: MediaQuery.of(context).size.height * 0.4,
      children: [
        _Content(
          items: items,
          value: value,
          onChanged: onChanged,
          onInit: onInit,
          onFinish: onFinish,
        ),
      ],
    );

    onFinish();
  }
}

class _Content extends StatefulWidget {
  final List<ExpenseDropdownItem> items;
  final ExpenseDropdownItem? value;
  final ValueChanged<ExpenseDropdownItem> onChanged;
  final VoidCallback onInit;
  final VoidCallback onFinish;

  const _Content({
    required this.items,
    required this.value,
    required this.onChanged,
    required this.onInit,
    required this.onFinish,
  });

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  ExpenseDropdownItem? _itemSelected;

  @override
  Widget build(BuildContext context) {
    onSelectedOption() {
      Future.delayed(const Duration(milliseconds: 200), () {
        Navigator.pop(context);
        widget.onInit();
      });
    }

    return Expanded(
      child: SingleChildScrollView(
        key: const Key('dropdown.scroll-items'),
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            ...widget.items.asMap().entries.map(
              (item) {
                //
                ExpenseListSelectPosition getLinePosition() {
                  return item.key == 0 ? ExpenseListSelectPosition.none : ExpenseListSelectPosition.top;
                }

                String label = item.value.label;

                return Semantics(
                  label: label,
                  hint: 'Toque duas vezes para ativar',
                  excludeSemantics: true,
                  child: GestureDetector(
                    key: Key('drawer-item-${item.key}'),
                    onTap: () {
                      setState(() => _itemSelected = item.value);

                      widget.onChanged(item.value);
                      onSelectedOption();
                    },
                    child: ExpenseListSelectLine(
                      label: label,
                      value: item.value,
                      type: ExpenseListSelectType.radiobutton,
                      groupValue: _itemSelected ?? widget.value,
                      linePosition: getLinePosition(),
                      onChanged: (e) {
                        setState(() => _itemSelected = e!);

                        widget.onChanged(e!);
                        onSelectedOption();
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
