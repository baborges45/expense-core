import 'dart:async';
import 'package:expense_core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ToastAnimated extends StatefulWidget {
  final Widget child;
  final VoidCallback onDismissed;
  final Duration duration;

  const ToastAnimated({
    super.key,
    required this.duration,
    required this.onDismissed,
    required this.child,
  });

  @override
  State<ToastAnimated> createState() => _AnimatedState();
}

class _AnimatedState extends State<ToastAnimated> {
  double _animation = -80;
  late Timer timer;

  @override
  void initState() {
    super.initState();

    initAnimation();
    timer = Timer(widget.duration, () {
      dismissedAnimation();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void initAnimation() async {
    await Future.delayed(const Duration(milliseconds: 1));
    setState(() => _animation = MediaQuery.of(context).padding.top);
  }

  void dismissedAnimation() async {
    timer.cancel();
    setState(() => _animation = -80);
    await Future.delayed(const Duration(milliseconds: 240));
    widget.onDismissed();
  }

  @override
  Widget build(BuildContext context) {
    var globalTokens = Provider.of<ExpenseThemeManager>(context).globals;

    return GestureDetector(
      onTap: dismissedAnimation,
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: globalTokens.motions.durations.moderate02,
            curve: globalTokens.motions.curves.expressiveEntrance,
            top: _animation,
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
