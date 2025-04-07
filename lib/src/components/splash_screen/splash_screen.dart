// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MudeSplashScreen extends StatelessWidget {
  // The splashcreen animation
  final Widget logo;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  const MudeSplashScreen({
    super.key,
    required this.logo,
    this.semanticsHint,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      width: size.width,
      child: logo,
    );
  }
}
