import 'package:flutter/material.dart';

import 'package:mude_core/core.dart';

class DropdownSelect {
  static open({
    required BuildContext context,
    required List<MudeDropdownItem> items,
    required VoidCallback onInit,
    required ValueChanged<MudeDropdownItem> onChanged,
    required VoidCallback onFinish,
    final MudeDropdownItem? value,
  }) async {
    await MudeDrawer.show(
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
  final List<MudeDropdownItem> items;
  final MudeDropdownItem? value;
  final ValueChanged<MudeDropdownItem> onChanged;
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
  MudeDropdownItem? _itemSelected;

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
                MudeListSelectPosition getLinePosition() {
                  return item.key == 0
                      ? MudeListSelectPosition.none
                      : MudeListSelectPosition.top;
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
                    child: MudeListSelectLine(
                      label: label,
                      value: item.value,
                      type: MudeListSelectType.radiobutton,
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
