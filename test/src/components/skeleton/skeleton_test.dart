import 'package:mude_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Skeleton',
    () {
      testWidgets(
        'Should render skeleton',
        (widgetTester) async {
          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeSkeleton(
                key: key,
              ),
            ),
          );

          await widgetTester.pump(const Duration(milliseconds: 1600));

          expect(find.byKey(key), findsOneWidget);
        },
      );

      testWidgets(
        'Should skeleton type circle',
        (widgetTester) async {
          final key = UniqueKey();
          MudeThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: MudeSkeleton(
                key: key,
                type: MudeSkeletonType.circle,
              ),
            ),
          );

          final container = widgetTester.widget<Container>(
            find.byType(Container),
          );
          final constraints = container.constraints as BoxConstraints;

          expect(constraints.maxHeight, tokens!.globals.shapes.size.s8x);
          expect(constraints.maxWidth, tokens!.globals.shapes.size.s8x);
        },
      );

      testWidgets(
        'Should skeleton set width and height',
        (widgetTester) async {
          final key = UniqueKey();
          double size = 100;

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeSkeleton(
                key: key,
                type: MudeSkeletonType.retangle,
                height: size,
                width: size,
              ),
            ),
          );

          final container = widgetTester.widget<Container>(
            find.byType(Container),
          );
          final constraints = container.constraints as BoxConstraints;

          expect(constraints.maxHeight, size);
          expect(constraints.maxWidth, size);
        },
      );

      testWidgets(
        'Should skeleton set border radius',
        (widgetTester) async {
          final key = UniqueKey();
          double size = 100;
          BorderRadius borderRadius = BorderRadius.circular(12);

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeSkeleton(
                key: key,
                type: MudeSkeletonType.retangle,
                height: size,
                width: size,
                borderRadius: borderRadius,
              ),
            ),
          );

          final container = widgetTester.widget<Container>(
            find.byType(Container),
          );
          final decoration = container.decoration as BoxDecoration;

          expect(decoration.borderRadius, borderRadius);
        },
      );

      testWidgets(
        'Should skeleton all diretions',
        (widgetTester) async {
          final key = UniqueKey();
          double size = 100;
          BorderRadius borderRadius = BorderRadius.circular(12);

          for (var direction in MudeSkeletonDirection.values) {
            await widgetTester.pumpWidget(
              Wrapper(
                child: MudeSkeleton(
                  key: key,
                  direction: direction,
                  height: size,
                  width: size,
                  borderRadius: borderRadius,
                ),
              ),
            );

            final skeleton = widgetTester.widget<MudeSkeleton>(
              find.byType(MudeSkeleton),
            );

            expect(skeleton.direction, direction);
          }
        },
      );
    },
  );

  group('Skeleton Accessibility', () {
    testWidgets(
      'Should verify accessibility',
      (widgetTester) async {
        final SemanticsHandle handle = widgetTester.ensureSemantics();

        await widgetTester.pumpWidget(
          const Wrapper(
            child: MudeSkeleton(
              semanticsLabel: 'Skeleton',
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
