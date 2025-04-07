import 'package:mude_core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PressedContainer extends StatefulWidget {
  final VoidCallback onPressed;
  final bool disabled;
  final Widget child;

  const PressedContainer({
    super.key,
    required this.onPressed,
    required this.disabled,
    required this.child,
  });

  @override
  State<PressedContainer> createState() => _PressedContainerState();
}

class _PressedContainerState extends State<PressedContainer> {
  bool _isPressed = false;

  void _onPressed(bool isPressed) {
    setState(() => _isPressed = isPressed);
  }

  @override
  Widget build(BuildContext context) {
    final tokens = Provider.of<MudeThemeManager>(context);
    final globalTokens = tokens.globals;

    double getOpacity() {
      if (widget.disabled) {
        return globalTokens.shapes.opacity.low;
      }

      return _isPressed ? globalTokens.shapes.opacity.superHigh : 1;
    }

    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (_) => _onPressed(true),
      onTapUp: (_) => _onPressed(false),
      onTapCancel: () => _onPressed(false),
      child: Opacity(
        opacity: getOpacity(),
        child: widget.child,
      ),
    );
  }
}
