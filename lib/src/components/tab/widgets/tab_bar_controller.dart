part of '../tab.dart';

class MudeTabBarController extends TabController {
  final Duration duration;
  final Curve curve;

  MudeTabBarController({
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
