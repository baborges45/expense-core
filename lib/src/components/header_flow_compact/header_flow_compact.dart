import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:mude_core/core.dart';

part 'widgets/_header.dart';

class MudeHeaderFlowCompact extends StatelessWidget {
  ///A string representing the title of the header.
  final String title;

  ///A string representing the description of the header.
  final String? description;

  ///An integer representing the total number of steps in the flow.
  final int totalStep;

  ///An integer representing the current step in the flow.
  final int currentStep;

  ///A boolean indicating whether to show the progress line.
  final bool showProgress;

  ///A boolean indicating whether to show the steps.
  final bool showSteps;

  ///(Optional)An  VoidCallback that will be called when the back button is pressed.
  final VoidCallback? onBack;

  ///(Optional) An [VoidCallback] that will be called when the close button is pressed.
  final VoidCallback? onClose;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsHeaderLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHeaderHint;

  ///A string value that indicates additional accessibility information.
  ///The default value is null in button back
  final String? semanticsButtonBackHint;

  ///A string value that indicates additional accessibility information.
  ///The default value is null in button close
  final String? semanticsButtonCloseHint;

  const MudeHeaderFlowCompact({
    super.key,
    required this.title,
    this.description,
    this.totalStep = 0,
    this.currentStep = 0,
    this.showProgress = false,
    this.showSteps = false,
    this.onClose,
    this.onBack,
    this.semanticsHeaderLabel,
    this.semanticsHeaderHint,
    this.semanticsButtonBackHint,
    this.semanticsButtonCloseHint,
  });

  @override
  Widget build(BuildContext context) {
    var globalTokens = Provider.of<MudeThemeManager>(context).globals;

    Widget getProgreeLine() {
      if (!showProgress) {
        return const Expanded(child: SizedBox());
      }

      int progress = 0;
      int totalStepCurrent = totalStep;

      if (currentStep > totalStepCurrent) {
        totalStepCurrent = currentStep;
      }

      if (totalStepCurrent > 0) {
        progress = (currentStep / totalStepCurrent * 100).round();
      }

      return ExcludeSemantics(
        child: Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.symmetric(
            horizontal: globalTokens.shapes.size.s3x,
          ),
          child: MudeProgressCircular(progress: progress),
        ),
      );
    }

    return Semantics(
      explicitChildNodes: true,
      header: true,
      label: semanticsHeaderLabel,
      hint: semanticsHeaderHint,
      child: SizedBox(
        height: globalTokens.shapes.size.s10x,
        child: Column(
          children: [
            Expanded(
              child: _Header(
                title: title,
                description: description,
                totalStep: totalStep,
                currentStep: currentStep,
                show: showSteps,
                onBack: onBack,
                onClose: onClose,
                semanticsButtonBackHint: semanticsButtonBackHint,
                semanticsButtonCloseHint: semanticsButtonCloseHint,
              ),
            ),
            getProgreeLine(),
          ],
        ),
      ),
    );
  }
}
