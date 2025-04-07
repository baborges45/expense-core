import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mude_core/core.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Search Accessibility',
    () {
      testWidgets(
        'Should verify accessibility',
        (widgetTester) async {
          final SemanticsHandle handle = widgetTester.ensureSemantics();
          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeSearchLine(
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
    'Search',
    () {
      testWidgets(
        'Should render search',
        (widgetTester) async {
          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeSearchLine(
                key: key,
              ),
            ),
          );

          expect(find.byKey(key), findsOneWidget);
        },
      );

      testWidgets(
        'Should search tap',
        (widgetTester) async {
          final key = UniqueKey();
          MudeThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: MudeSearchLine(
                key: key,
              ),
            ),
          );

          await widgetTester.press(find.byKey(key));
          await widgetTester.pumpAndSettle();

          final container = widgetTester.widget<Container>(
            find.byType(Container),
          );

          final decoration = container.decoration as BoxDecoration;
          expect(decoration.color, tokens!.alias.mixin.pressedOutline);
        },
      );

      testWidgets(
        'Should search filled and focused',
        (widgetTester) async {
          final key = UniqueKey();
          MudeThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: MudeSearchLine(
                key: key,
              ),
            ),
          );

          final input = find.byType(TextField);
          await widgetTester.tap(input);
          await widgetTester.enterText(input, '123');
          await widgetTester.pumpAndSettle();

          final containers = find.byType(Container);
          final container = widgetTester.widget<Container>(
            containers.first,
          );

          final decoration = container.decoration as BoxDecoration;
          final border = decoration.border as Border;
          expect(border.bottom.color, tokens!.alias.color.active.borderColor);
        },
      );

      testWidgets(
        'Should search clear',
        (widgetTester) async {
          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeSearchLine(
                key: key,
              ),
            ),
          );

          final input = find.byType(TextField);
          await widgetTester.tap(input);
          await widgetTester.enterText(input, '123');
          await widgetTester.pumpAndSettle();

          // clear
          final clearButton = find.byKey(const Key('input-search.clear'));
          await widgetTester.tap(clearButton);
          await widgetTester.pumpAndSettle();

          expect(find.text('123'), findsNothing);
        },
      );
    },
  );
}
