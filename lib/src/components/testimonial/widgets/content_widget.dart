import 'package:flutter/material.dart';
import 'package:mude_core/core.dart';
import 'package:mude_core/src/components/testimonial/widgets/label_description_widget.dart';

import 'label_widget.dart';
import 'leading_widget.dart';
import 'trailing_widget.dart';

class ContentWidget extends StatelessWidget {
  final String label;

  final dynamic leading;
  final MudeButtonIcon? trailingButton;
  final bool isLayoutContainer;
  final bool inverse;
  final String description;

  const ContentWidget({
    super.key,
    required this.label,
    this.leading,
    this.trailingButton,
    this.isLayoutContainer = false,
    this.inverse = false,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // label testimonial
        SizedBox(
          height: 85,
          child: LabelWidget(label),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Leading widget
            Row(
              children: [
                LeadingWidget(
                  child: leading,
                  inverse: inverse,
                ),
                LabelDescriptionWidget(description),
              ],
            ),

            TrailingWidget(trailingButton: trailingButton),

            // trailing widget
          ],
        ),
      ],
    );
  }
}
