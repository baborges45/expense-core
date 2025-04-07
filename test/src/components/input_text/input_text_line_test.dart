import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mude_core/core.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Input Text',
    () {
      testWidgets(
        'Should render input password',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeInputTextLine(
                key: key,
                label: label,
              ),
            ),
          );

          expect(find.byKey(key), findsOneWidget);
          expect(find.text(label), findsOneWidget);
        },
      );

      testWidgets(
        'Should render input password showing support text',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const supporttext = 'Support text';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeInputTextLine(
                key: key,
                label: label,
                supportText: supporttext,
              ),
            ),
          );

          expect(find.text(supporttext), findsOneWidget);
        },
      );

      testWidgets(
        'Should render input password disabled',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const supporttext = 'Support text';
          MudeThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: MudeInputTextLine(
                key: key,
                label: label,
                supportText: supporttext,
                disabled: true,
              ),
            ),
          );

          final widget = widgetTester.widget<TextField>(
            find.byType(TextField),
          );
          final style = widget.style as TextStyle;

          expect(style.color, tokens!.alias.color.disabled.placeholderColor);
        },
      );

      testWidgets(
        'Should render input password pressed',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const supporttext = 'Support text';
          MudeThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: MudeInputTextLine(
                key: key,
                label: label,
                supportText: supporttext,
              ),
            ),
          );

          await widgetTester.press(find.byKey(key));
          await widgetTester.pump(const Duration(milliseconds: 200));

          final widget = widgetTester.widget<Container>(
            find.byKey(const Key('input-text.container')),
          );
          final decoration = widget.decoration as BoxDecoration;

          expect(decoration.color, tokens!.alias.mixin.pressedOutline);
        },
      );

      testWidgets(
        'Should render input password with error',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const supporttext = 'Support text';
          MudeThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: MudeInputTextLine(
                key: key,
                label: label,
                supportText: supporttext,
                hasError: true,
              ),
            ),
          );

          final widget = widgetTester.widget<TextField>(
            find.byType(TextField),
          );
          final style = widget.style as TextStyle;

          expect(style.color, tokens!.alias.color.negative.placeholderColor);
        },
      );

      testWidgets(
        'Should render input password filled',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const supporttext = 'Support text';
          MudeThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: MudeInputTextLine(
                key: key,
                label: label,
                supportText: supporttext,
              ),
            ),
          );

          await widgetTester.tap(find.byType(TextField));
          await widgetTester.pumpAndSettle();

          final widget = widgetTester.widget<TextField>(find.byType(TextField));
          final style = widget.style as TextStyle;

          expect(style.color, tokens!.alias.color.active.placeholderColor);
        },
      );
    },
  );

  group('Input Text Accessibility', () {
    testWidgets(
      'Should verify accessibility',
      (widgetTester) async {
        final SemanticsHandle handle = widgetTester.ensureSemantics();

        await widgetTester.pumpWidget(
          const Wrapper(
            child: MudeInputTextLine(
              label: 'Label',
              semanticsLabel: 'Label',
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
