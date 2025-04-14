part of '../tab.dart';

class ExpenseTabBarController extends TabController {
  final Duration duration;
  final Curve curve;

  ExpenseTabBarController({
    required super.length,
    required super.vsync,
    required this.duration,
    required this.curve,
  });

  @override
  void animateTo(int value, {Duration? duration, Curve curve = Curves.ease}) {
    super.animateTo(
      value,
      duration: this.duration,
      curve: this.curve,
    );
  }
}
