import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

part 'widgets/_header.dart';
part 'widgets/_title.dart';

class ExpenseHeaderFlowJumbo extends StatelessWidget {
  ///A string representing the title of the header.
  final String title;

  ///A string representing the description of the header.
  final String description;

  ///An integer representing the total number of steps in the flow.
  final int totalStep;

  ///An integer representing the current step in the flow.
  final int currentStep;

  ///A boolean indicating whether to show the progress line.
  final bool showProgress;

  ///A boolean indicating whether to show the steps.
  final bool showSteps;

  ///(Optional) An [VoidCallback] that will be called when the back button is pressed.
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

  const ExpenseHeaderFlowJumbo({
    super.key,
    required this.title,
    this.description = '',
    this.onClose,
    this.totalStep = 0,
    this.currentStep = 0,
    this.showSteps = false,
    this.showProgress = false,
    this.onBack,
    this.semanticsHeaderLabel,
    this.semanticsHeaderHint,
    this.semanticsButtonBackHint,
    this.semanticsButtonCloseHint,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var aliasTokens = tokens.alias;

    Widget getProgreeLine() {
      if (!showProgress) {
        return const SizedBox.shrink();
      }

      int progress = 0;
      int totalStepCurrent = totalStep;

      if (currentStep > totalStepCurrent) {
        totalStepCurrent = currentStep;
      }

      if (totalStepCurrent > 0) {
        progress = (currentStep / totalStepCurrent * 100).round();
      }

      return Container(
        alignment: Alignment.bottomCenter,
        child: ExpenseProgressCircular(
          progress: progress,
          size: ExpenseProgressCircularSize.sm,
        ),
      );
    }

    return Semantics(
      explicitChildNodes: true,
      header: true,
      label: semanticsHeaderLabel ?? title,
      child: Container(
        color: aliasTokens.color.elements.bgColor01,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Header(
              showProgress: showProgress,
              totalStep: totalStep,
              currentStep: currentStep,
              onClose: onClose,
              onBack: onBack,
              semanticsButtonBackHint: semanticsButtonBackHint,
              semanticsButtonCloseHint: semanticsButtonCloseHint,
            ),
            _Title(
              title: title,
              description: description,
              totalStep: totalStep,
              currentStep: currentStep,
              show: showSteps,
              leading: ExcludeSemantics(
                child: getProgreeLine(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
