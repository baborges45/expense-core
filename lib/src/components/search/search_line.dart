import 'package:flutter/material.dart';
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

import 'mixins/properties_mixin.dart';
import 'widgets/input_widget.dart';

class MudeSearchLine extends StatefulWidget {
  ///(Optional) A TextEditingController that controls the text being edited in the search bar.
  final TextEditingController? controller;

  ///(Optional) A FocusNode that manages the focus state of the search bar.
  final FocusNode? focusNode;

  ///(Optional) A TextInputType that defines the type of keyboard to use when editing text in the search bar.
  final TextInputType? keyboardType;

  ///A boolean that determines whether the search bar can be edited or not.
  ///The default value is false.
  final bool readOnly;

  ///A boolean that determines whether the search bar should automatically request focus when the widget is mounted.
  ///The default value is false.
  final bool autofocus;

  ///A boolean that determines whether the search bar should auto-correct user input.
  ///The default value is true.
  final bool autocorrect;

  ///(Optional) A callback function that is called whenever the text in the search bar changes.
  final ValueChanged<String>? onChanged;

  ///(Optional) A callback function that is called when editing is complete.
  final VoidCallback? onEditingComplete;

  ///(Optional) A callback function that is called when the user submits the search query.
  final ValueChanged<String>? onSubmitted;

  ///(Optional) A callback function that is called when text clear.
  final VoidCallback? onClear;

  ///(Optional) A boolean that determines whether the search bar is enabled or not.
  final bool? enabled;

  ///(Optional) A string that defines the placeholder text for the search bar.
  final String? placeholder;

  ///(Optional) A TextInputAction that defines the text input action to use when editing text in the search bar.
  final TextInputAction? textInputAction;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  const MudeSearchLine({
    super.key,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.readOnly = false,
    this.autofocus = false,
    this.autocorrect = true,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onClear,
    this.enabled,
    this.placeholder,
    this.textInputAction,
    this.semanticsLabel,
    this.semanticsHint,
  });

  @override
  State<MudeSearchLine> createState() => _MudeSearchLineState();
}

class _MudeSearchLineState extends State<MudeSearchLine> with PropertiesMixin {
  late FocusNode _focusNode;
  late TextEditingController _controller;

  bool _isPressed = false;
  bool _isFocussed = false;
  bool _isFilled = false;

  _onPressedDown(_) {
    setState(() => _isPressed = true);
  }

  _onPressedUp(_) {
    setState(() => _isPressed = false);
  }

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocussed = _focusNode.hasFocus;
      });
    });

    _controller.addListener(() {
      setState(() {
        _isFilled = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    Color getBackgroundColor() {
      return _isPressed && !_isFocussed && !_isFilled
          ? aliasTokens.mixin.pressedOutline
          : aliasTokens.color.elements.bgColor01;
    }

    Color getBorderColor() {
      return _isFocussed
          ? aliasTokens.color.active.borderColor
          : aliasTokens.color.elements.borderColor;
    }

    return GestureDetector(
      onTapDown: _onPressedDown,
      onTapUp: _onPressedUp,
      onTapCancel: () => _onPressedUp(null),
      child: Container(
        alignment: Alignment.center,
        height: globalTokens.shapes.size.s8x,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: getBackgroundColor(),
          border: Border(
            bottom: BorderSide(
              width: aliasTokens.defaultt.borderWidth,
              color: getBorderColor(),
            ),
          ),
        ),

        // Input
        child: InputWidget(
          controller: _controller,
          focusNode: _focusNode,
          isFilled: _isFilled,
          isFocussed: _isFocussed,
          onClear: () {
            setState(() => _isFilled = false);
            if (widget.onClear != null) widget.onClear!();
          },
          keyboardType: widget.keyboardType,
          readOnly: widget.readOnly,
          autofocus: widget.autofocus,
          autocorrect: widget.autocorrect,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
          onSubmitted: widget.onSubmitted,
          enabled: widget.enabled,
          placeholder: widget.placeholder,
          textInputAction: widget.textInputAction,
          semanticsHint: widget.semanticsHint,
          semanticsLabel: widget.semanticsLabel,
        ),
      ),
    );
  }
}
