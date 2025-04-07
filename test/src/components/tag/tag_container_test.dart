import 'package:mude_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Should verify accessibility',
    () {
      testWidgets(
        'Should be rendered correctly',
        (widgetTester) async {
          final key = UniqueKey();

          final SemanticsHandle handle = widgetTester.ensureSemantics();
          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeTagContainer(
                'Tag',
                key: key,
              ),
            ),
          );

          await expectLater(
            widgetTester,
            meetsGuideline(androidTapTargetGuideline),
          );

          await expectLater(
            widgetTester,
            meetsGuideline(iOSTapTargetGuideline),
          );

          await expectLater(
            widgetTester,
            meetsGuideline(labeledTapTargetGuideline),
          );

          await expectLater(
            widgetTester,
            meetsGuideline(textContrastGuideline),
          );
          handle.dispose();
        },
      );
    },
  );
  group(
    'Tag Container',
    () {
      testWidgets(
        'Should be rendered correctly',
        (widgetTester) async {
          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeTagContainer(
                'Tag',
                key: key,
              ),
            ),
          );
          expect(find.text('Tag'), findsOneWidget);
        },
      );

      testWidgets(
        'Should render all status correctly',
        (widgetTester) async {
          final key = UniqueKey();

          for (var status in MudeTagStatus.values) {
            await widgetTester.pumpWidget(
              Wrapper(
                child: MudeTagContainer(
                  'Tag',
                  status: status,
                  key: key,
                ),
              ),
            );

            expect(find.byKey(key), findsOneWidget);
          }
        },
      );

      testWidgets(
        'Should tag inverted',
        (widgetTester) async {
          final key = UniqueKey();
          MudeThemeManager? tokens;

          for (var type in MudeTagStatus.values) {
            await widgetTester.pumpWidget(
              Wrapper(
                onTokens: (t) => tokens = t,
                child: MudeTagContainer(
                  'Tag',
                  key: key,
                  status: type,
                  inverse: true,
                ),
              ),
            );

            final widget = find.byType(Container);
            final container = widgetTester.widget<Container>(widget);
            final decoration = container.decoration as BoxDecoration;

            expect(decoration.color, tokens!.alias.color.inverse.bgColor);
          }
        },
      );
    },
  );
}
