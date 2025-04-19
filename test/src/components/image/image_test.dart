import 'package:expense_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Image',
    () {
      testWidgets(
        'Should render image',
        (widgetTester) async {
          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseImage.asset('test/assets/image.png'),
            ),
          );

          expect(find.byType(ExpenseImage), findsOneWidget);
        },
      );

      testWidgets(
        'Should image aspect ratio',
        (widgetTester) async {
          for (var aspect in ExpenseImageAspectRatio.values) {
            await widgetTester.pumpWidget(
              Wrapper(
                child: ExpenseImage.asset(
                  'test/assets/image.png',
                  aspectRatio: aspect,
                ),
              ),
            );

            final image = widgetTester.widget<ExpenseImage>(find.byType(ExpenseImage));
            expect(image.aspectRatio, aspect);
          }
        },
      );

      testWidgets(
        'Should image width',
        (widgetTester) async {
          double width = 100;

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseImage.asset(
                'test/assets/image.png',
                width: width,
              ),
            ),
          );

          final image = widgetTester.widget<ExpenseImage>(find.byType(ExpenseImage));
          expect(image.width, width);
        },
      );

      testWidgets(
        'Should image fill container',
        (widgetTester) async {
          ExpenseThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: ExpenseImage.asset(
                'test/assets/image.png',
                fillContainer: true,
              ),
            ),
          );

          final widget = widgetTester.widget<ClipRRect>(find.byType(ClipRRect));
          final borderRadius = BorderRadius.circular(
            tokens!.globals.shapes.border.radiusMd,
          );

          expect(widget.borderRadius, borderRadius);
        },
      );

      testWidgets(
        'Should image load from network',
        (widgetTester) async {
          mockNetworkImagesFor(() async {
            await widgetTester.pumpWidget(
              Wrapper(
                child: ExpenseImage.network(
                  'https://example.com/some_image.jpg',
                  fillContainer: true,
                ),
              ),
            );

            expect(find.byType(ExpenseImage), findsOneWidget);
          });
        },
      );
    },
  );

  group('Image Accessibility', () {
    testWidgets(
      'Should verify accessibility',
      (widgetTester) async {
        final SemanticsHandle handle = widgetTester.ensureSemantics();

        await widgetTester.pumpWidget(
          Wrapper(
            child: ExpenseImage.asset(
              'test/assets/image.png',
              semanticsLabel: 'Image',
              semanticsHint: 'Image Hint',
            ),
          ),
        );

        // Checks that tappable nodes have a minimum size of 48 by 48 pixels
        // for Android.
        await expectLater(
          widgetTester,
          meetsGuideline(androidTapTargetGuideline),
        );

        // Checks that tappable nodes have a minimum size of 44 by 44 pixels
        // for iOS.
        await expectLater(
          widgetTester,
          meetsGuideline(iOSTapTargetGuideline),
        );

        // Checks that touch targets with a tap or long press action are labeled.
        await expectLater(
          widgetTester,
          meetsGuideline(labeledTapTargetGuideline),
        );

        // Checks whether semantic nodes meet the minimum text contrast levels.
        // The recommended text contrast is 3:1 for larger text
        // (18 point and above regular).
        await expectLater(
          widgetTester,
          meetsGuideline(textContrastGuideline),
        );

        handle.dispose();
      },
    );
  });
}
