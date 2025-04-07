import 'package:mude_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Super Drawer',
    () {
      testWidgets(
        'Should render super drawer',
        (widgetTester) async {
          await widgetTester.pumpWidget(
            Wrapper(
              child: const SizedBox.shrink(),
              onTap: (context) {
                MudeSuperDrawer.show(
                  context,
                  children: [
                    MudeButton(
                      label: 'Close',
                      onPressed: () => debugPrint(''),
                    ),
                  ],
                );
              },
            ),
          );

          final button = find.byKey(const Key('wrapper-tap'));
          await widgetTester.tap(button);
          await widgetTester.pump(const Duration(milliseconds: 800));

          expect(find.byType(Column), findsWidgets);
          expect(find.byType(MudeButton), findsOneWidget);
        },
      );

      testWidgets(
        'Should render close super drawer',
        (widgetTester) async {
          await widgetTester.pumpWidget(
            Wrapper(
              child: const SizedBox.shrink(),
              onTap: (context) {
                MudeSuperDrawer.show(
                  context,
                  children: [],
                );
              },
            ),
          );

          // open
          final button = find.byKey(const Key('wrapper-tap'));
          await widgetTester.tap(button);
          await widgetTester.pump(const Duration(milliseconds: 800));

          // close
          final buttonClose = find.byType(MudeButtonIcon);
          await widgetTester.tap(buttonClose);
          await widgetTester.pump(const Duration(milliseconds: 800));

          expect(find.byType(MudeSuperDrawer), findsNothing);
        },
      );
    },
  );

  group('Super Drawer Accessibility', () {
    testWidgets(
      'Should verify accessibility',
      (widgetTester) async {
        final SemanticsHandle handle = widgetTester.ensureSemantics();
        await widgetTester.pumpWidget(
          Wrapper(
            child: const SizedBox.shrink(),
            onTap: (context) {
              MudeSuperDrawer.show(
                context,
                children: [],
              );
            },
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

        handle.dispose();
      },
    );
  });
}
