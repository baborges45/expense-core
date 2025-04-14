import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

import 'input_code_description.dart';

class InputCodeControl extends StatefulWidget {
  final int itemsCount;
  final String value;
  final ValueChanged<String> onChanged;
  final String description;
  final ExpenseInputCodeController? controller;
  final ValueChanged<bool>? onFinished;
  final ExpenseInputCodeHiperLink? hiperlink;
  final FocusNode? focusNode;
  final bool autofocus;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final String? semanticsLabel;
  final String? semanticsHint;

  final Function(
    VoidCallback onFocus,
    String text,
    bool actived,
    bool focused,
  ) onRender;

  const InputCodeControl({
    super.key,
    required this.onRender,
    required this.value,
    required this.onChanged,
    this.itemsCount = 3,
    this.description = '',
    this.autofocus = false,
    this.controller,
    this.onFinished,
    this.hiperlink,
    this.focusNode,
    this.textCapitalization,
    this.keyboardType = TextInputType.number,
    this.semanticsLabel,
    this.semanticsHint,
  });

  @override
  State<InputCodeControl> createState() => _InputCodeControlState();
}

class _InputCodeControlState extends State<InputCodeControl> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  String _getValue(int index) {
    if (widget.value.length > index) return widget.value[index];

    return '';
  }

  bool _getActived(int index) {
    return widget.value.length == index;
  }

  void _onChanged(String code) {
    widget.onChanged(code);

    if (widget.onFinished != null) {
      widget.onFinished!(code.length == widget.itemsCount);
    }
  }

  @override
  void initState() {
    super.initState();

    _focusNode = widget.focusNode ?? FocusNode();

    _focusNode.addListener(() {
      setState(() => _isFocused = _focusNode.hasFocus);

      if (!_focusNode.hasFocus) {
        FocusScope.of(context).unfocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var globalTokens = Provider.of<ExpenseThemeManager>(context).globals;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            // TextField Control
            Visibility(
              visible: false,
              maintainSize: true,
              maintainState: true,
              maintainAnimation: true,
              child: SizedBox(
                height: globalTokens.shapes.size.s7x,
                child: TextField(
                  onTapOutside: (PointerDownEvent event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  controller: widget.controller,
                  focusNode: _focusNode,
                  keyboardType: widget.keyboardType,
                  textInputAction: TextInputAction.done,
                  onChanged: _onChanged,
                  maxLength: widget.itemsCount,
                  autofocus: widget.autofocus,
                  textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
                ),
              ),
            ),

            // Input Code
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ...List.generate(
                  widget.itemsCount,
                  (index) {
                    return widget.onRender(
                      () => _focusNode.requestFocus(),
                      _getValue(index),
                      _getActived(index),
                      _isFocused,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: globalTokens.shapes.spacing.s2x),

        // Text description
        InputCodeDescription(
          description: widget.description,
        ),
      ],
    );
  }
}
