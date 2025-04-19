import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';

class Select<T> {
  static open({
    required BuildContext context,
    required List<ExpenseInputSelectItem> items,
    required ValueChanged<ExpenseInputSelectItem> onChanged,
    required VoidCallback onInit,
    required VoidCallback onFinish,
    final ExpenseInputSelectItem? value,
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
  final List<ExpenseInputSelectItem> items;
  final ExpenseInputSelectItem? value;
  final ValueChanged<ExpenseInputSelectItem> onChanged;
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
  ExpenseInputSelectItem? _itemSelected;

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
        key: const Key('input-select.scroll-items'),
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            ...widget.items.asMap().entries.map(
              (item) {
                //
                ExpenseListSelectPosition getLinePosition() {
                  return item.key == 0 ? ExpenseListSelectPosition.none : ExpenseListSelectPosition.top;
                }

                return GestureDetector(
                  onTap: () {
                    setState(() => _itemSelected = item.value);

                    widget.onChanged(item.value);
                    onSelectedOption();
                  },
                  child: ExpenseListSelectLine(
                    label: item.value.label,
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
