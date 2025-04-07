part of '../header_flow_jumbo.dart';

class _Title extends StatelessWidget {
  final String title;
  final String description;
  final int totalStep;
  final int currentStep;
  final bool show;
  final Widget leading;

  const _Title({
    required this.title,
    required this.description,
    required this.totalStep,
    required this.currentStep,
    required this.show,
    required this.leading,
  });

  @override
  Widget build(BuildContext context) {
    var globalTokens = Provider.of<MudeThemeManager>(context).globals;
    final spacing = globalTokens.shapes.spacing;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: spacing.s3x,
        vertical: spacing.s4x,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (description.isNotEmpty) ...[
                  MudeDescription(
                    description,
                    semanticsLabel: description,
                  ),
                  SizedBox(height: spacing.s1x),
                ],
                MudeHeading(
                  title,
                  size: MudeHeadingSize.lg,
                ),
              ],
            ),
          ),
          SizedBox(
            width: spacing.s3x,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: leading,
          ),
        ],
      ),
    );
  }
}
